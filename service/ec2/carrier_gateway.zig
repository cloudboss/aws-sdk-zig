const CarrierGatewayState = @import("carrier_gateway_state.zig").CarrierGatewayState;
const Tag = @import("tag.zig").Tag;

/// Describes a carrier gateway.
pub const CarrierGateway = struct {
    /// The ID of the carrier gateway.
    carrier_gateway_id: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the carrier gateway.
    owner_id: ?[]const u8,

    /// The state of the carrier gateway.
    state: ?CarrierGatewayState,

    /// The tags assigned to the carrier gateway.
    tags: ?[]const Tag,

    /// The ID of the VPC associated with the carrier gateway.
    vpc_id: ?[]const u8,
};
