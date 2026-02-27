pub const LogType = enum {
    waf_logs,

    pub const json_field_names = .{
        .waf_logs = "WAF_LOGS",
    };
};
