const NetworkDirection = @import("network_direction.zig").NetworkDirection;

/// Contains information about the network connection.
pub const NetworkConnection = struct {
    /// The direction in which the network traffic is flowing.
    direction: NetworkDirection,

    pub const json_field_names = .{
        .direction = "Direction",
    };
};
