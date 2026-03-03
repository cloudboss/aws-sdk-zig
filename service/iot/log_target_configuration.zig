const LogLevel = @import("log_level.zig").LogLevel;
const LogTarget = @import("log_target.zig").LogTarget;

/// The target configuration.
pub const LogTargetConfiguration = struct {
    /// The logging level.
    log_level: ?LogLevel = null,

    /// A log target
    log_target: ?LogTarget = null,

    pub const json_field_names = .{
        .log_level = "logLevel",
        .log_target = "logTarget",
    };
};
