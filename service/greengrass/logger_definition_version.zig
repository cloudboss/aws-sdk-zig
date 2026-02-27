const Logger = @import("logger.zig").Logger;

/// Information about a logger definition version.
pub const LoggerDefinitionVersion = struct {
    /// A list of loggers.
    loggers: ?[]const Logger,

    pub const json_field_names = .{
        .loggers = "Loggers",
    };
};
