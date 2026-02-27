const BridgeState = @import("bridge_state.zig").BridgeState;

/// Displays details of the selected bridge.
pub const ListedBridge = struct {
    /// The ARN of the bridge.
    bridge_arn: []const u8,

    /// The state of the bridge.
    bridge_state: BridgeState,

    /// The type of the bridge.
    bridge_type: []const u8,

    /// The name of the bridge.
    name: []const u8,

    /// The ARN of the gateway associated with the bridge.
    placement_arn: []const u8,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .bridge_state = "BridgeState",
        .bridge_type = "BridgeType",
        .name = "Name",
        .placement_arn = "PlacementArn",
    };
};
