const TransitGatewayMulitcastDomainAssociationState = @import("transit_gateway_mulitcast_domain_association_state.zig").TransitGatewayMulitcastDomainAssociationState;

/// Describes the subnet association with the transit gateway multicast domain.
pub const SubnetAssociation = struct {
    /// The state of the subnet association.
    state: ?TransitGatewayMulitcastDomainAssociationState,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,
};
