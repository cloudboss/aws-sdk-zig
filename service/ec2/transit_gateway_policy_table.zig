const TransitGatewayPolicyTableState = @import("transit_gateway_policy_table_state.zig").TransitGatewayPolicyTableState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway policy table.
pub const TransitGatewayPolicyTable = struct {
    /// The timestamp when the transit gateway policy table was created.
    creation_time: ?i64,

    /// The state of the transit gateway policy table
    state: ?TransitGatewayPolicyTableState,

    /// he key-value pairs associated with the transit gateway policy table.
    tags: ?[]const Tag,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,

    /// The ID of the transit gateway policy table.
    transit_gateway_policy_table_id: ?[]const u8,
};
