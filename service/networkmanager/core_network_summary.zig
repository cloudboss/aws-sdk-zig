const CoreNetworkState = @import("core_network_state.zig").CoreNetworkState;
const Tag = @import("tag.zig").Tag;

/// Returns summary information about a core network.
pub const CoreNetworkSummary = struct {
    /// a core network ARN.
    core_network_arn: ?[]const u8,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// The description of a core network.
    description: ?[]const u8,

    /// The global network ID.
    global_network_id: ?[]const u8,

    /// The ID of the account owner.
    owner_account_id: ?[]const u8,

    /// The state of a core network.
    state: ?CoreNetworkState,

    /// The key-value tags associated with a core network summary.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .core_network_arn = "CoreNetworkArn",
        .core_network_id = "CoreNetworkId",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
        .tags = "Tags",
    };
};
