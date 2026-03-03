const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const PinpointDestination = @import("pinpoint_destination.zig").PinpointDestination;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// An object that defines the event destination. Specifically, it defines which
/// services
/// receive events from emails sent using the configuration set that the event
/// destination
/// is associated with. Also defines the types of events that are sent to the
/// event
/// destination.
pub const EventDestinationDefinition = struct {
    /// An object that defines an Amazon CloudWatch destination for email events.
    /// You can use Amazon CloudWatch to
    /// monitor and gain insights on your email sending metrics.
    cloud_watch_destination: ?CloudWatchDestination = null,

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
    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    /// An array that specifies which events Amazon Pinpoint should send to the
    /// destinations in this
    /// `EventDestinationDefinition`.
    matching_event_types: ?[]const EventType = null,

    /// An object that defines a Amazon Pinpoint destination for email events. You
    /// can use Amazon Pinpoint events
    /// to create attributes in Amazon Pinpoint projects. You can use these
    /// attributes to create segments
    /// for your campaigns.
    pinpoint_destination: ?PinpointDestination = null,

    /// An object that defines an Amazon SNS destination for email events. You can
    /// use Amazon SNS to
    /// send notification when certain email events occur.
    sns_destination: ?SnsDestination = null,

    pub const json_field_names = .{
        .cloud_watch_destination = "CloudWatchDestination",
        .enabled = "Enabled",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .pinpoint_destination = "PinpointDestination",
        .sns_destination = "SnsDestination",
    };
};
