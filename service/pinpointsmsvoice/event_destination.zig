const CloudWatchLogsDestination = @import("cloud_watch_logs_destination.zig").CloudWatchLogsDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// An object that defines an event destination.
pub const EventDestination = struct {
    cloud_watch_logs_destination: ?CloudWatchLogsDestination,

    /// Indicates whether or not the event destination is enabled. If the event
    /// destination is enabled, then Amazon Pinpoint sends response data to the
    /// specified event destination.
    enabled: ?bool,

    kinesis_firehose_destination: ?KinesisFirehoseDestination,

    matching_event_types: ?[]const EventType,

    /// A name that identifies the event destination configuration.
    name: ?[]const u8,

    sns_destination: ?SnsDestination,

    pub const json_field_names = .{
        .cloud_watch_logs_destination = "CloudWatchLogsDestination",
        .enabled = "Enabled",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .name = "Name",
        .sns_destination = "SnsDestination",
    };
};
