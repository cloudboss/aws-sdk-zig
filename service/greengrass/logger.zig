const LoggerComponent = @import("logger_component.zig").LoggerComponent;
const LoggerLevel = @import("logger_level.zig").LoggerLevel;
const LoggerType = @import("logger_type.zig").LoggerType;

/// Information about a logger
pub const Logger = struct {
    /// The component that will be subject to logging.
    component: LoggerComponent,

    /// A descriptive or arbitrary ID for the logger. This value must be unique
    /// within the logger definition version. Max length is 128 characters with
    /// pattern ''[a-zA-Z0-9:_-]+''.
    id: []const u8,

    /// The level of the logs.
    level: LoggerLevel,

    /// The amount of file space, in KB, to use if the local file system is used for
    /// logging purposes.
    space: ?i32 = null,

    /// The type of log output which will be used.
    @"type": LoggerType,

    pub const json_field_names = .{
        .component = "Component",
        .id = "Id",
        .level = "Level",
        .space = "Space",
        .@"type" = "Type",
    };
};
