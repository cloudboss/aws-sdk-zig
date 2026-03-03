const LogDestination = @import("log_destination.zig").LogDestination;
const LogLevel = @import("log_level.zig").LogLevel;

/// The `LoggingConfiguration` data type is used to set CloudWatch Logs
/// options.
pub const LoggingConfiguration = struct {
    /// An array of objects that describes where your execution history events will
    /// be logged.
    /// Limited to size 1. Required, if your log level is not set to `OFF`.
    destinations: ?[]const LogDestination = null,

    /// Determines whether execution data is included in your log. When set to
    /// `false`,
    /// data is excluded.
    include_execution_data: bool = false,

    /// Defines which category of execution history events are logged.
    level: ?LogLevel = null,

    pub const json_field_names = .{
        .destinations = "destinations",
        .include_execution_data = "includeExecutionData",
        .level = "level",
    };
};
