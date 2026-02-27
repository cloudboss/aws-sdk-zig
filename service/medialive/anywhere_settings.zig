/// Elemental anywhere settings
pub const AnywhereSettings = struct {
    /// The ID of the channel placement group for the channel.
    channel_placement_group_id: ?[]const u8,

    /// The ID of the cluster for the channel.
    cluster_id: ?[]const u8,

    pub const json_field_names = .{
        .channel_placement_group_id = "ChannelPlacementGroupId",
        .cluster_id = "ClusterId",
    };
};
