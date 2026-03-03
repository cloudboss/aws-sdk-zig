const ChannelStorageSummary = @import("channel_storage_summary.zig").ChannelStorageSummary;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;

/// A summary of information about a channel.
pub const ChannelSummary = struct {
    /// The name of the channel.
    channel_name: ?[]const u8 = null,

    /// Where channel data is stored.
    channel_storage: ?ChannelStorageSummary = null,

    /// When the channel was created.
    creation_time: ?i64 = null,

    /// The last time when a new message arrived in the channel.
    ///
    /// IoT Analytics updates this value at most once per minute for one channel.
    /// Hence, the `lastMessageArrivalTime` value is an approximation.
    ///
    /// This feature only applies to messages that arrived in the data store after
    /// October 23, 2020.
    last_message_arrival_time: ?i64 = null,

    /// The last time the channel was updated.
    last_update_time: ?i64 = null,

    /// The status of the channel.
    status: ?ChannelStatus = null,

    pub const json_field_names = .{
        .channel_name = "channelName",
        .channel_storage = "channelStorage",
        .creation_time = "creationTime",
        .last_message_arrival_time = "lastMessageArrivalTime",
        .last_update_time = "lastUpdateTime",
        .status = "status",
    };
};
