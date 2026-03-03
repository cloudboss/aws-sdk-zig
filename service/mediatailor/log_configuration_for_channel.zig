const LogType = @import("log_type.zig").LogType;

/// The log configuration for the channel.
pub const LogConfigurationForChannel = struct {
    /// The log types.
    log_types: ?[]const LogType = null,

    pub const json_field_names = .{
        .log_types = "LogTypes",
    };
};
