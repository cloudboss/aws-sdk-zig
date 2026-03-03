const CloudWatchLogsDestination = @import("cloud_watch_logs_destination.zig").CloudWatchLogsDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// An object that defines a single event destination.
pub const EventDestinationDefinition = struct {
    cloud_watch_logs_destination: ?CloudWatchLogsDestination = null,

    /// Indicates whether or not the event destination is enabled. If the event
    /// destination is enabled, then Amazon Pinpoint sends response data to the
    /// specified event destination.
    enabled: ?bool = null,

    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    matching_event_types: ?[]const EventType = null,

    sns_destination: ?SnsDestination = null,

    pub const json_field_names = .{
        .cloud_watch_logs_destination = "CloudWatchLogsDestination",
        .enabled = "Enabled",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .sns_destination = "SnsDestination",
    };
};
