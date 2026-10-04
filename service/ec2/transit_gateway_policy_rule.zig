const TransitGatewayPolicyRuleMetaData = @import("transit_gateway_policy_rule_meta_data.zig").TransitGatewayPolicyRuleMetaData;

/// Describes a rule associated with a transit gateway policy.
pub const TransitGatewayPolicyRule = struct {
    /// The destination CIDR block for the transit gateway policy rule.
    destination_cidr_block: ?[]const u8 = null,

    /// The destination port or port range for the transit gateway policy rule.
    destination_port_range: ?[]const u8 = null,

    /// The meta data tags used for the transit gateway policy rule.
    meta_data: ?TransitGatewayPolicyRuleMetaData = null,

    /// The protocol used by the transit gateway policy rule.
    protocol: ?[]const u8 = null,

    /// The source CIDR block for the transit gateway policy rule.
    source_cidr_block: ?[]const u8 = null,

    /// The source port or port range for the transit gateway policy rule.
    source_port_range: ?[]const u8 = null,
};
