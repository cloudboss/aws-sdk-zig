const SystemLogLevel = @import("system_log_level.zig").SystemLogLevel;

/// The capacity provider's Amazon CloudWatch Logs configuration settings.
pub const CapacityProviderLoggingConfig = struct {
    /// The name of the Amazon CloudWatch log group the capacity provider sends logs
    /// to. By default, Lambda capacity providers send logs to a default log group
    /// named `/aws/lambda/capacity-provider/<capacity provider name>`. To use a
    /// different log group, enter an existing log group or enter a new log group
    /// name.
    log_group: ?[]const u8 = null,

    /// Set this property to filter the system logs for your capacity provider that
    /// Lambda sends to CloudWatch. Lambda only sends system logs at the selected
    /// level of detail and lower, where `DEBUG` is the highest level and `WARN` is
    /// the lowest.
    system_log_level: ?SystemLogLevel = null,

    pub const json_field_names = .{
        .log_group = "LogGroup",
        .system_log_level = "SystemLogLevel",
    };
};
