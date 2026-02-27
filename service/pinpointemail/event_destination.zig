const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const PinpointDestination = @import("pinpoint_destination.zig").PinpointDestination;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// In Amazon Pinpoint, *events* include message sends, deliveries, opens,
/// clicks, bounces, and complaints. *Event destinations* are places that
/// you can send information about these events to. For example, you can send
/// event data to
/// Amazon SNS to receive notifications when you receive bounces or complaints,
/// or you can use
/// Amazon Kinesis Data Firehose to stream data to Amazon S3 for long-term
/// storage.
pub const EventDestination = struct {
    /// An object that defines an Amazon CloudWatch destination for email events.
    /// You can use Amazon CloudWatch to
    /// monitor and gain insights on your email sending metrics.
    cloud_watch_destination: ?CloudWatchDestination,

    /// If `true`, the event destination is enabled. When the event destination is
    /// enabled, the specified event types are sent to the destinations in this
    /// `EventDestinationDefinition`.
    ///
    /// If `false`, the event destination is disabled. When the event destination
    /// is disabled, events aren't sent to the specified destinations.
    enabled: bool = false,

    /// An object that defines an Amazon Kinesis Data Firehose destination for email
    /// events. You can use Amazon Kinesis Data Firehose to
    /// stream data to other services, such as Amazon S3 and Amazon Redshift.
    kinesis_firehose_destination: ?KinesisFirehoseDestination,

    /// The types of events that Amazon Pinpoint sends to the specified event
    /// destinations.
    matching_event_types: []const EventType,

    /// A name that identifies the event destination.
    name: []const u8,

    /// An object that defines a Amazon Pinpoint destination for email events. You
    /// can use Amazon Pinpoint events
    /// to create attributes in Amazon Pinpoint projects. You can use these
    /// attributes to create segments
    /// for your campaigns.
    pinpoint_destination: ?PinpointDestination,

    /// An object that defines an Amazon SNS destination for email events. You can
    /// use Amazon SNS to
    /// send notification when certain email events occur.
    sns_destination: ?SnsDestination,

    pub const json_field_names = .{
        .cloud_watch_destination = "CloudWatchDestination",
        .enabled = "Enabled",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .name = "Name",
        .pinpoint_destination = "PinpointDestination",
        .sns_destination = "SnsDestination",
    };
};
