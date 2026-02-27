const NatGatewayApplianceState = @import("nat_gateway_appliance_state.zig").NatGatewayApplianceState;
const NatGatewayApplianceModifyState = @import("nat_gateway_appliance_modify_state.zig").NatGatewayApplianceModifyState;
const NatGatewayApplianceType = @import("nat_gateway_appliance_type.zig").NatGatewayApplianceType;

/// Information about an appliance attached to a NAT Gateway, providing managed
/// security solutions for traffic filtering and inspection.
pub const NatGatewayAttachedAppliance = struct {
    /// The Amazon Resource Name (ARN) of the attached appliance, identifying the
    /// specific proxy or security appliance resource.
    appliance_arn: ?[]const u8,

    /// The current attachment state of the appliance.
    attachment_state: ?NatGatewayApplianceState,

    /// The failure code if the appliance attachment or modification operation
    /// failed.
    failure_code: ?[]const u8,

    /// A descriptive message explaining the failure if the appliance attachment or
    /// modification operation failed.
    failure_message: ?[]const u8,

    /// The current modification state of the appliance.
    modification_state: ?NatGatewayApplianceModifyState,

    /// The type of appliance attached to the NAT Gateway. For network firewall
    /// proxy functionality, this will be "network-firewall-proxy".
    type: ?NatGatewayApplianceType,

    /// The VPC endpoint ID used to route traffic from application VPCs to the proxy
    /// for inspection and filtering.
    vpc_endpoint_id: ?[]const u8,
};
