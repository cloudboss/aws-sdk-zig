const aws = @import("aws");

const DestinationSummary = @import("destination_summary.zig").DestinationSummary;
const EventStreamState = @import("event_stream_state.zig").EventStreamState;

/// An instance of EventStream in a list of EventStreams.
pub const EventStreamSummary = struct {
    /// Summary information about the Kinesis data stream.
    destination_summary: ?DestinationSummary,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A unique identifier for the event stream.
    event_stream_arn: []const u8,

    /// The name of the event stream.
    event_stream_name: []const u8,

    /// The operational state of destination stream for export.
    state: EventStreamState,

    /// The timestamp when the `State` changed to `STOPPED`.
    stopped_since: ?i64,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .destination_summary = "DestinationSummary",
        .domain_name = "DomainName",
        .event_stream_arn = "EventStreamArn",
        .event_stream_name = "EventStreamName",
        .state = "State",
        .stopped_since = "StoppedSince",
        .tags = "Tags",
    };
};
