const TransitGatewayPolicyRule = @import("transit_gateway_policy_rule.zig").TransitGatewayPolicyRule;
const TransitGatewayPolicyTableEntryState = @import("transit_gateway_policy_table_entry_state.zig").TransitGatewayPolicyTableEntryState;

/// Describes a transit gateway policy table entry
pub const TransitGatewayPolicyTableEntry = struct {
    /// The policy rule associated with the transit gateway policy table.
    policy_rule: ?TransitGatewayPolicyRule = null,

    /// The rule number for the transit gateway policy table entry.
    policy_rule_number: ?[]const u8 = null,

    /// The state of the transit gateway policy table entry.
    state: ?TransitGatewayPolicyTableEntryState = null,

    /// The ID of the target route table.
    target_route_table_id: ?[]const u8 = null,
};
