const LogDestination = @import("log_destination.zig").LogDestination;

/// The logging configuration for a simulation.
pub const LoggingConfiguration = struct {
    /// A list of the locations where SimSpace Weaver sends simulation log data.
    destinations: ?[]const LogDestination = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
    };
};
