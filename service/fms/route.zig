const DestinationType = @import("destination_type.zig").DestinationType;
const TargetType = @import("target_type.zig").TargetType;

/// Describes a route in a route table.
pub const Route = struct {
    /// The destination of the route.
    destination: ?[]const u8,

    /// The type of destination for the route.
    destination_type: ?DestinationType,

    /// The route's target.
    target: ?[]const u8,

    /// The type of target for the route.
    target_type: ?TargetType,

    pub const json_field_names = .{
        .destination = "Destination",
        .destination_type = "DestinationType",
        .target = "Target",
        .target_type = "TargetType",
    };
};
