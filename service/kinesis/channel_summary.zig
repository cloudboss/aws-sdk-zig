const ChannelDestinationType = @import("channel_destination_type.zig").ChannelDestinationType;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const ChannelStreamIdentifier = @import("channel_stream_identifier.zig").ChannelStreamIdentifier;

/// A summary of a channel, returned by ListChannels.
pub const ChannelSummary = struct {
    /// The Amazon Resource Name (ARN) of the channel.
    channel_arn: []const u8,

    /// The time at which the channel was created.
    channel_creation_timestamp: i64,

    /// The destination type of the channel. Valid values:
    ///
    /// * `S3` - Delivery to a general purpose Amazon S3 bucket.
    ///
    /// * `S3_TABLES` - Delivery to streaming tables on Apache Iceberg.
    channel_destination_type: ChannelDestinationType,

    /// The unique identifier of the channel.
    channel_id: []const u8,

    /// The name of the channel.
    channel_name: []const u8,

    /// The current status of the channel. Valid values:
    ///
    /// * `CREATING` - The channel is being created.
    ///
    /// * `ACTIVE` - The channel is ready to deliver records.
    ///
    /// * `UPDATING` - The channel configuration is being updated.
    ///
    /// * `DELETING` - The channel is being deleted.
    ///
    /// * `FAILED` - See `ChannelStatusReason` for the failure cause.
    channel_status: ChannelStatus,

    /// A message describing the reason for a `FAILED` status.
    channel_status_reason: ?[]const u8 = null,

    /// The source streams associated with the channel.
    streams: []const ChannelStreamIdentifier,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .channel_creation_timestamp = "ChannelCreationTimestamp",
        .channel_destination_type = "ChannelDestinationType",
        .channel_id = "ChannelId",
        .channel_name = "ChannelName",
        .channel_status = "ChannelStatus",
        .channel_status_reason = "ChannelStatusReason",
        .streams = "Streams",
    };
};
