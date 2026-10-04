/// A NAT gateway that a proxy mode firewall uses to proxy traffic. This is used
/// in CreateFirewall when `NoSourcePreservation` is `TRUE`.
pub const NatGatewayMapping = struct {
    /// A unique identifier for the NAT gateway to use with proxy resources.
    nat_gateway_id: []const u8,

    pub const json_field_names = .{
        .nat_gateway_id = "NatGatewayId",
    };
};
