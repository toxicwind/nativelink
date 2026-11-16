# AGENTS.md — nativelink (barn product, realized 2026-11-13)

REAPI remote-execution engine (worker + scheduler + local CAS fast tier).
BuildBuddy (flux) is the control-plane/cache; this executor's CAS/AC stores are
gRPC-backed by BuildBuddy REAPI (:25218) — the hook the Pens intended.

## Runtime
- Binary: `~/.local/bin/nativelink` (Rust, 0.6.0; already in bin manifest).
- Daemon: `pitchfork start barn/nativelink` (config `barn/pitchfork.toml`
  `[daemons.nativelink]`, run `ranch/forge/ops/nativelink/run.sh`).
- Config: `deploy/Pens/nativelink.Pens.json5` — **nativelink 0.6.0 schema**:
  `services.*` are MAPS keyed by instance_name (e.g. `{ "": { ac_store } }`),
  NOT arrays like the older deployment-examples use.
- Ports (SSOT): frontend/scheduler `NATIVELINK_FRONTEND_PORT=25155`, worker_api
  `NATIVELINK_WORKER_PORT=25157`.
- Health: `curl http://127.0.0.1:25157/health` returns 200 (health service must
  have `path: "/health"`; root 404s).

## Hook to BuildBuddy
`stores.BB_CAS_STORE` / `BB_AC_STORE` point at `grpc://127.0.0.1:${BUILDBUDDY_GRPC_PORT}`
(:25218). `CAS_FAST_SLOW_STORE` = 20GB local disk fast tier, slow tier = BuildBuddy CAS.