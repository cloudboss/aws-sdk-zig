pub const GatewayPolicyEngineMode = enum {
    log_only,
    enforce,

    pub const json_field_names = .{
        .log_only = "LOG_ONLY",
        .enforce = "ENFORCE",
    };
};
