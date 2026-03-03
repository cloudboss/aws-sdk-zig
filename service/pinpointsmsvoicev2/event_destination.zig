const CloudWatchLogsDestination = @import("cloud_watch_logs_destination.zig").CloudWatchLogsDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// Contains information about an event destination.
///
/// Event destinations are associated with configuration sets, which enable you
/// to publish message sending events to CloudWatch, Firehose, or Amazon SNS.
pub const EventDestination = struct {
    /// An object that contains information about an event destination that sends
    /// logging events to Amazon CloudWatch logs.
    cloud_watch_logs_destination: ?CloudWatchLogsDestination = null,

    /// When set to true events will be logged.
    enabled: bool,

    /// The name of the EventDestination.
    event_destination_name: []const u8,

    /// An object that contains information about an event destination for logging
    /// to Amazon Data Firehose.
    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    /// An array of event types that determine which events to log.
    ///
    /// The `TEXT_SENT` event type is not supported.
    matching_event_types: []const EventType,

    /// An object that contains information about an event destination that sends
    /// logging events to Amazon SNS.
    sns_destination: ?SnsDestination = null,

    pub const json_field_names = .{
        .cloud_watch_logs_destination = "CloudWatchLogsDestination",
        .enabled = "Enabled",
        .event_destination_name = "EventDestinationName",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .sns_destination = "SnsDestination",
    };
};
