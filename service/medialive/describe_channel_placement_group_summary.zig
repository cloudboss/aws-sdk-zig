const ChannelPlacementGroupState = @import("channel_placement_group_state.zig").ChannelPlacementGroupState;

/// Contains the response for ListChannelPlacementGroups
pub const DescribeChannelPlacementGroupSummary = struct {
    /// The ARN of this ChannelPlacementGroup. It is automatically assigned when the
    /// ChannelPlacementGroup is created.
    arn: ?[]const u8,

    /// Used in ListChannelPlacementGroupsResult
    channels: ?[]const []const u8,

    /// The ID of the Cluster that the Node belongs to.
    cluster_id: ?[]const u8,

    /// The ID of the ChannelPlacementGroup. Unique in the AWS account. The ID is
    /// the resource-id portion of the ARN.
    id: ?[]const u8,

    /// The name that you specified for the ChannelPlacementGroup.
    name: ?[]const u8,

    /// An array with one item, which is the single Node that is associated with the
    /// ChannelPlacementGroup.
    nodes: ?[]const []const u8,

    /// The current state of the ChannelPlacementGroup.
    state: ?ChannelPlacementGroupState,

    pub const json_field_names = .{
        .arn = "Arn",
        .channels = "Channels",
        .cluster_id = "ClusterId",
        .id = "Id",
        .name = "Name",
        .nodes = "Nodes",
        .state = "State",
    };
};
