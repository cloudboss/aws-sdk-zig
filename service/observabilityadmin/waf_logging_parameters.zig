const LoggingFilter = @import("logging_filter.zig").LoggingFilter;
const WAFLogType = @import("waf_log_type.zig").WAFLogType;
const FieldToMatch = @import("field_to_match.zig").FieldToMatch;

/// Configuration parameters for WAF logging, including redacted fields and
/// logging filters.
pub const WAFLoggingParameters = struct {
    /// A filter configuration that determines which WAF log records to include or
    /// exclude.
    logging_filter: ?LoggingFilter,

    /// The type of WAF logs to collect (currently supports WAF_LOGS).
    log_type: ?WAFLogType,

    /// The fields to redact from WAF logs to protect sensitive information.
    redacted_fields: ?[]const FieldToMatch,

    pub const json_field_names = .{
        .logging_filter = "LoggingFilter",
        .log_type = "LogType",
        .redacted_fields = "RedactedFields",
    };
};
