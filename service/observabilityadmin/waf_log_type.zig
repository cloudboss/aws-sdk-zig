/// Enumeration of supported WAF log types. Currently only WAF_LOGS is
/// supported.
pub const WAFLogType = enum {
    waf_logs,

    pub const json_field_names = .{
        .waf_logs = "WAF_LOGS",
    };
};
