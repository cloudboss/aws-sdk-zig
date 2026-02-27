const LogConfiguration = @import("log_configuration.zig").LogConfiguration;

/// A collection of log configurations.
pub const LogConfigurations = struct {
    /// Parameters for publishing logs to Amazon CloudWatch Logs.
    cloudwatch: ?LogConfiguration,

    pub const json_field_names = .{
        .cloudwatch = "Cloudwatch",
    };
};
