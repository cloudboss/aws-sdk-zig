const LocalGatewayRouteTableMode = @import("local_gateway_route_table_mode.zig").LocalGatewayRouteTableMode;
const StateReason = @import("state_reason.zig").StateReason;
const Tag = @import("tag.zig").Tag;

/// Describes a local gateway route table.
pub const LocalGatewayRouteTable = struct {
    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the local gateway route table.
    local_gateway_route_table_arn: ?[]const u8,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8,

    /// The mode of the local gateway route table.
    mode: ?LocalGatewayRouteTableMode,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the local gateway route
    /// table.
    owner_id: ?[]const u8,

    /// The state of the local gateway route table.
    state: ?[]const u8,

    /// Information about the state change.
    state_reason: ?StateReason,

    /// The tags assigned to the local gateway route table.
    tags: ?[]const Tag,
};
