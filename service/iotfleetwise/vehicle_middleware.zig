const VehicleMiddlewareProtocol = @import("vehicle_middleware_protocol.zig").VehicleMiddlewareProtocol;

/// The vehicle middleware defined as a type of network interface. Examples of
/// vehicle
/// middleware include `ROS2` and `SOME/IP`.
pub const VehicleMiddleware = struct {
    /// The name of the vehicle middleware.
    name: []const u8,

    /// The protocol name of the vehicle middleware.
    protocol_name: VehicleMiddlewareProtocol,

    pub const json_field_names = .{
        .name = "name",
        .protocol_name = "protocolName",
    };
};
