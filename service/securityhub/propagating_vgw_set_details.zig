/// Describes a virtual private gateway propagating route.
pub const PropagatingVgwSetDetails = struct {
    /// The ID of the virtual private gateway.
    gateway_id: ?[]const u8,

    pub const json_field_names = .{
        .gateway_id = "GatewayId",
    };
};
