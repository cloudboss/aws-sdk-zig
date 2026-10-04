const ChannelDestinationType = @import("channel_destination_type.zig").ChannelDestinationType;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;

/// Summary information about a channel returned by ListChannels.
pub const ChannelInfo = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the channel.
    channel_arn: []const u8,

    /// The name of the channel.
    channel_name: []const u8,

    /// The Amazon Resource Name (ARN) of the in-flight cluster operation. Returned
    /// only while the channel is in CREATING, UPDATING, or DELETING.
    cluster_operation_arn: ?[]const u8 = null,

    /// The time when the channel was created.
    creation_time: i64,

    /// The type of destination configured for the channel.
    destination_type: ChannelDestinationType,

    /// The current lifecycle state of the channel.
    status: ChannelStatus,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .channel_name = "ChannelName",
        .cluster_operation_arn = "ClusterOperationArn",
        .creation_time = "CreationTime",
        .destination_type = "DestinationType",
        .status = "Status",
    };
};
