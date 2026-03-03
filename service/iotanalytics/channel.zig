const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const ChannelStorage = @import("channel_storage.zig").ChannelStorage;

/// A collection of data from an MQTT topic. Channels archive the raw,
/// unprocessed messages
/// before publishing the data to a pipeline.
pub const Channel = struct {
    /// The ARN of the channel.
    arn: ?[]const u8 = null,

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

    /// When the channel was last updated.
    last_update_time: ?i64 = null,

    /// The name of the channel.
    name: ?[]const u8 = null,

    /// How long, in days, message data is kept for the channel.
    retention_period: ?RetentionPeriod = null,

    /// The status of the channel.
    status: ?ChannelStatus = null,

    /// Where channel data is stored. You can choose one of `serviceManagedS3` or
    /// `customerManagedS3` storage. If not specified, the default is
    /// `serviceManagedS3`. You can't change this storage option after the channel
    /// is
    /// created.
    storage: ?ChannelStorage = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .last_message_arrival_time = "lastMessageArrivalTime",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .retention_period = "retentionPeriod",
        .status = "status",
        .storage = "storage",
    };
};
