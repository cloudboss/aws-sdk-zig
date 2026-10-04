const TransitGatewayRequestPolicyRuleMetaData = @import("transit_gateway_request_policy_rule_meta_data.zig").TransitGatewayRequestPolicyRuleMetaData;

/// The matching criteria for a transit gateway policy table entry.
pub const TransitGatewayRequestPolicyRule = struct {
    /// The destination CIDR block for the policy rule.
    destination_cidr_block: ?[]const u8 = null,

    /// The destination port or port range for the policy rule. You can specify a
    /// port range only when `Protocol` is `6` (TCP) or `17` (UDP); for all other
    /// protocols, this value must be `*`.
    destination_port_range: ?[]const u8 = null,

    /// The metadata key-value pair for the policy rule.
    meta_data: ?TransitGatewayRequestPolicyRuleMetaData = null,

    /// The protocol for the policy rule. Valid values are `1` (ICMP), `6` (TCP),
    /// `17` (UDP), `47` (GRE), or `*` for all protocols.
    protocol: ?[]const u8 = null,

    /// The source CIDR block for the policy rule.
    source_cidr_block: ?[]const u8 = null,

    /// The source port or port range for the policy rule. You can specify a port
    /// range only when `Protocol` is `6` (TCP) or `17` (UDP); for all other
    /// protocols, this value must be `*`.
    source_port_range: ?[]const u8 = null,
};
