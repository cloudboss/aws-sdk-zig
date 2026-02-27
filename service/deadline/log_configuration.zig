const aws = @import("aws");

/// Log configuration details.
pub const LogConfiguration = struct {
    /// The log configuration error details.
    @"error": ?[]const u8,

    /// The log drivers for worker related logs.
    log_driver: []const u8,

    /// The options for a log driver.
    options: ?[]const aws.map.StringMapEntry,

    /// The parameters for the log configuration.
    parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .@"error" = "error",
        .log_driver = "logDriver",
        .options = "options",
        .parameters = "parameters",
    };
};
