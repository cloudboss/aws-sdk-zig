const NetworkACLEntry = @import("network_acl_entry.zig").NetworkACLEntry;

/// The structure of the transit gateway and network configuration that is used
/// to connect the kdb environment to an internal network.
pub const TransitGatewayConfiguration = struct {
    /// The rules that define how you manage the outbound traffic from kdb network
    /// to your internal network.
    attachment_network_acl_configuration: ?[]const NetworkACLEntry = null,

    /// The routing CIDR on behalf of kdb environment. It could be any "/26 range in
    /// the 100.64.0.0 CIDR space. After providing, it will be added to the
    /// customer's transit gateway routing table so that the traffics could be
    /// routed to kdb network.
    routable_cidr_space: []const u8,

    /// The identifier of the transit gateway created by the customer to connect
    /// outbound traffics from kdb network to your internal network.
    transit_gateway_id: []const u8,

    pub const json_field_names = .{
        .attachment_network_acl_configuration = "attachmentNetworkAclConfiguration",
        .routable_cidr_space = "routableCIDRSpace",
        .transit_gateway_id = "transitGatewayID",
    };
};
