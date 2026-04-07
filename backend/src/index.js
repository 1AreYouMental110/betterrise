const jsonHeaders = {
  "content-type": "application/json; charset=UTF-8",
  "access-control-allow-origin": "*",
  "access-control-allow-methods": "GET,POST,OPTIONS",
  "access-control-allow-headers": "content-type,api-key",
};

const defaultWhitelist = {
  Announcement: null,
  BlacklistedUsers: {},
  KillVape: false,
  KillPealzware: false,
  WhitelistedTags: {},
  WhitelistedUsers: {},
};

function json(data, init = {}) {
  return new Response(JSON.stringify(data), {
    status: init.status || 200,
    headers: { ...jsonHeaders, ...(init.headers || {}) },
  });
}

function responseText(text, init = {}) {
  return new Response(text, {
    status: init.status || 200,
    headers: { ...jsonHeaders, ...(init.headers || {}) },
  });
}

async function readJson(env, key, fallback) {
  const raw = await env.PEALZWARE_STORE.get(key);
  if (!raw) return fallback;
  try {
    return JSON.parse(raw);
  } catch {
    return fallback;
  }
}

async function writeJson(env, key, value) {
  await env.PEALZWARE_STORE.put(key, JSON.stringify(value));
}

function normalizeColor(tagColor) {
  if (!tagColor) return [210, 43, 43];
  if (Array.isArray(tagColor)) return tagColor;
  const namedColors = {
    red: [255, 0, 0],
    blue: [0, 102, 255],
    green: [0, 255, 0],
    purple: [128, 0, 128],
    pink: [255, 0, 255],
    yellow: [255, 255, 0],
    orange: [255, 165, 0],
    white: [255, 255, 255],
    black: [0, 0, 0],
  };
  return namedColors[String(tagColor).toLowerCase()] || [210, 43, 43];
}

function upsertWhitelistEntry(whitelist, body, apiKey) {
  const username = String(body.roblox_username || body.RobloxUsername || "").trim();
  if (!username) {
    return { ok: false, error: "roblox_username is required" };
  }

  const key = username.toLowerCase();
  const existing = whitelist.WhitelistedUsers[key] || {};
  const next = {
    ...existing,
    roblox_username: username,
    hwid: body.hwid || existing.hwid || "",
    level: typeof existing.level === "number" ? existing.level : 1,
    attackable: existing.attackable === true,
    updated_at: new Date().toISOString(),
    editor_api_key_hint: apiKey ? `${String(apiKey).slice(0, 4)}***` : existing.editor_api_key_hint || "",
  };

  const tagText = String(body.tag_text || body.TagText || "").trim();
  const tagColor = body.tag_color || body.TagColor;
  if (tagText || tagColor) {
    next.tags = [{
      text: tagText || (existing.tags && existing.tags[0] && existing.tags[0].text) || "PEALZWARE",
      color: normalizeColor(tagColor || (existing.tags && existing.tags[0] && existing.tags[0].color)),
    }];
  }

  whitelist.WhitelistedUsers[key] = next;
  return { ok: true, entry: next };
}

async function listCommands(env) {
  const commands = await readJson(env, "commands", []);
  return Array.isArray(commands) ? commands : [];
}

export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return responseText("");
    }

    const url = new URL(request.url);
    const path = url.pathname.replace(/\/+$/, "") || "/";

    try {
      if (request.method === "GET" && path === "/health") {
        return json({ ok: true, service: "pealzware-api" });
      }

      if (request.method === "GET" && (path === "/" || path === "/whitelist")) {
        const whitelist = await readJson(env, "whitelist", defaultWhitelist);
        return json(whitelist);
      }

      if (request.method === "POST" && path === "/edit_wl") {
        const apiKey = request.headers.get("api-key") || "";
        const body = await request.json().catch(() => null);
        if (!body || typeof body !== "object") {
          return json({ error: "Invalid JSON body" }, { status: 400 });
        }
        const whitelist = await readJson(env, "whitelist", defaultWhitelist);
        const result = upsertWhitelistEntry(whitelist, body, apiKey);
        if (!result.ok) {
          return json({ error: result.error }, { status: 400 });
        }
        await writeJson(env, "whitelist", whitelist);
        return json({
          success: true,
          message: "Whitelist data updated.",
          entry: result.entry,
        });
      }

      if (path === "/GlobalFunctions.json/commands") {
        if (request.method === "GET") {
          return json({ commands: await listCommands(env) });
        }

        if (request.method === "POST") {
          const apiKey = request.headers.get("api-key") || "";
          const body = await request.json().catch(() => null);
          if (!body || typeof body !== "object") {
            return json({ error: "Invalid JSON body" }, { status: 400 });
          }

          const commands = await listCommands(env);
          const command = {
            id: crypto.randomUUID(),
            command: String(body.command || ""),
            sendername: String(body.sendername || ""),
            receiver: String(body.receiver || ""),
            args: Array.isArray(body.args) ? body.args : [],
            created_at: new Date().toISOString(),
            api_key_hint: apiKey ? `${String(apiKey).slice(0, 4)}***` : "",
          };
          commands.unshift(command);
          await writeJson(env, "commands", commands.slice(0, 100));
          return json({
            success: true,
            message: `Queued ${command.command || "command"} for ${command.receiver || "target"}.`,
            commandId: command.id,
          });
        }
      }

      if (path === "/reportdetector") {
        const username = String(url.searchParams.get("user") || "").trim().toLowerCase();
        if (request.method === "GET") {
          if (!username) {
            return json({ error: "user is required" }, { status: 400 });
          }
          const reports = await readJson(env, `reports:${username}`, []);
          return json(Array.isArray(reports) ? reports : []);
        }

        if (request.method === "POST") {
          const body = await request.json().catch(() => null);
          if (!body || typeof body !== "object") {
            return json({ error: "Invalid JSON body" }, { status: 400 });
          }
          const target = String(body.user || body.username || "").trim().toLowerCase();
          if (!target) {
            return json({ error: "user is required" }, { status: 400 });
          }
          const reports = await readJson(env, `reports:${target}`, []);
          reports.push({
            guild_id: String(body.guild_id || "manual"),
            Reports: body.Reports && typeof body.Reports === "object" ? body.Reports : {},
          });
          await writeJson(env, `reports:${target}`, reports.slice(-25));
          return json({ success: true, message: "Report stored." });
        }
      }

      return json({ error: "Not found" }, { status: 404 });
    } catch (error) {
      return json({ error: String(error && error.message ? error.message : error) }, { status: 500 });
    }
  },
};
