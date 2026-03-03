const RetryConfigCriteria = @import("retry_config_criteria.zig").RetryConfigCriteria;

/// Over-the-air (OTA) task retry config.
pub const OtaTaskExecutionRetryConfig = struct {
    /// The list of retry config criteria.
    retry_config_criteria: ?[]const RetryConfigCriteria = null,

    pub const json_field_names = .{
        .retry_config_criteria = "RetryConfigCriteria",
    };
};
