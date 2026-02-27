const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const EventBridgeDestination = @import("event_bridge_destination.zig").EventBridgeDestination;
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
    cloud_watch_destination: ?CloudWatchDestination,

    /// If `true`, the event destination is enabled. When the event destination is
    /// enabled, the specified event types are sent to the destinations in this
    /// `EventDestinationDefinition`.
    ///
    /// If `false`, the event destination is disabled. When the event destination
    /// is disabled, events aren't sent to the specified destinations.
    enabled: bool = false,

    /// An object that defines an Amazon EventBridge destination for email events.
    /// You can use Amazon EventBridge to
    /// send notifications when certain email events occur.
    event_bridge_destination: ?EventBridgeDestination,

    /// An object that defines an Amazon Kinesis Data Firehose destination for email
    /// events. You can use Amazon Kinesis Data Firehose to
    /// stream data to other services, such as Amazon S3 and Amazon Redshift.
    kinesis_firehose_destination: ?KinesisFirehoseDestination,

    /// An array that specifies which events the Amazon SES API v2 should send to
    /// the destinations in
    /// this `EventDestinationDefinition`.
    matching_event_types: ?[]const EventType,

    /// An object that defines an Amazon Pinpoint project destination for email
    /// events. You can send
    /// email event data to a Amazon Pinpoint project to view metrics using the
    /// Transactional Messaging
    /// dashboards that are built in to Amazon Pinpoint. For more information, see
    /// [Transactional
    /// Messaging
    /// Charts](https://docs.aws.amazon.com/pinpoint/latest/userguide/analytics-transactional-messages.html) in the *Amazon Pinpoint User Guide*.
    pinpoint_destination: ?PinpointDestination,

    /// An object that defines an Amazon SNS destination for email events. You can
    /// use Amazon SNS to
    /// send notifications when certain email events occur.
    sns_destination: ?SnsDestination,

    pub const json_field_names = .{
        .cloud_watch_destination = "CloudWatchDestination",
        .enabled = "Enabled",
        .event_bridge_destination = "EventBridgeDestination",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .pinpoint_destination = "PinpointDestination",
        .sns_destination = "SnsDestination",
    };
};
