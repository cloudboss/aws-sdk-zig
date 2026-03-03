const LoggingConfigurationStatusCode = @import("logging_configuration_status_code.zig").LoggingConfigurationStatusCode;

/// The status of the logging configuration.
pub const LoggingConfigurationStatus = struct {
    /// The current status of the current rules and alerting logging configuration.
    ///
    /// These logging configurations are only for rules and alerting logs.
    status_code: LoggingConfigurationStatusCode,

    /// If failed, the reason for the failure.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
