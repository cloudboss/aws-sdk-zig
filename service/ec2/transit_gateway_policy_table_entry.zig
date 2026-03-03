const TransitGatewayPolicyRule = @import("transit_gateway_policy_rule.zig").TransitGatewayPolicyRule;

/// Describes a transit gateway policy table entry
pub const TransitGatewayPolicyTableEntry = struct {
    /// The policy rule associated with the transit gateway policy table.
    policy_rule: ?TransitGatewayPolicyRule = null,

    /// The rule number for the transit gateway policy table entry.
    policy_rule_number: ?[]const u8 = null,

    /// The ID of the target route table.
    target_route_table_id: ?[]const u8 = null,
};
