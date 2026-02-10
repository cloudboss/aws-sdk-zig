const TransitGatewayPolicyRuleMetaData = @import("transit_gateway_policy_rule_meta_data.zig").TransitGatewayPolicyRuleMetaData;

/// Describes a rule associated with a transit gateway policy.
pub const TransitGatewayPolicyRule = struct {
    /// The destination CIDR block for the transit gateway policy rule.
    destination_cidr_block: ?[]const u8,

    /// The port range for the transit gateway policy rule. Currently this is set to
    /// * (all).
    destination_port_range: ?[]const u8,

    /// The meta data tags used for the transit gateway policy rule.
    meta_data: ?TransitGatewayPolicyRuleMetaData,

    /// The protocol used by the transit gateway policy rule.
    protocol: ?[]const u8,

    /// The source CIDR block for the transit gateway policy rule.
    source_cidr_block: ?[]const u8,

    /// The port range for the transit gateway policy rule. Currently this is set to
    /// * (all).
    source_port_range: ?[]const u8,
};
