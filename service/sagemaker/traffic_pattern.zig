const Phase = @import("phase.zig").Phase;
const Stairs = @import("stairs.zig").Stairs;
const TrafficType = @import("traffic_type.zig").TrafficType;

/// Defines the traffic pattern of the load test.
pub const TrafficPattern = struct {
    /// Defines the phases traffic specification.
    phases: ?[]const Phase = null,

    /// Defines the stairs traffic pattern.
    stairs: ?Stairs = null,

    /// Defines the traffic patterns. Choose either `PHASES` or `STAIRS`.
    traffic_type: ?TrafficType = null,

    pub const json_field_names = .{
        .phases = "Phases",
        .stairs = "Stairs",
        .traffic_type = "TrafficType",
    };
};
