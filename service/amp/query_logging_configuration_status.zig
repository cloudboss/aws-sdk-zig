const QueryLoggingConfigurationStatusCode = @import("query_logging_configuration_status_code.zig").QueryLoggingConfigurationStatusCode;

/// The status information for a query logging configuration.
pub const QueryLoggingConfigurationStatus = struct {
    /// The current status of the query logging configuration.
    status_code: QueryLoggingConfigurationStatusCode,

    /// If there is a failure, the reason for the failure.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
