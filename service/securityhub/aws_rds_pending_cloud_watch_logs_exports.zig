/// Identifies the log types to enable and disable.
pub const AwsRdsPendingCloudWatchLogsExports = struct {
    /// A list of log types that are being disabled.
    log_types_to_disable: ?[]const []const u8 = null,

    /// A list of log types that are being enabled.
    log_types_to_enable: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .log_types_to_disable = "LogTypesToDisable",
        .log_types_to_enable = "LogTypesToEnable",
    };
};
