const GlobalNetworkState = @import("global_network_state.zig").GlobalNetworkState;
const Tag = @import("tag.zig").Tag;

/// Describes a global network. This is a single private network acting as a
/// high-level container for your network objects, including an Amazon Web
/// Services-managed Core Network.
pub const GlobalNetwork = struct {
    /// The date and time that the global network was created.
    created_at: ?i64,

    /// The description of the global network.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the global network.
    global_network_arn: ?[]const u8,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// The state of the global network.
    state: ?GlobalNetworkState,

    /// The tags for the global network.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .global_network_arn = "GlobalNetworkArn",
        .global_network_id = "GlobalNetworkId",
        .state = "State",
        .tags = "Tags",
    };
};
