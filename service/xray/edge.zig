const Alias = @import("alias.zig").Alias;
const HistogramEntry = @import("histogram_entry.zig").HistogramEntry;
const EdgeStatistics = @import("edge_statistics.zig").EdgeStatistics;

/// Information about a connection between two services. An edge can be a
/// synchronous connection, such as typical
/// call between client and service, or an asynchronous link, such as a Lambda
/// function which retrieves an event from an
/// SNS queue.
pub const Edge = struct {
    /// Aliases for the edge.
    aliases: ?[]const Alias = null,

    /// Describes an asynchronous connection, with a value of `link`.
    edge_type: ?[]const u8 = null,

    /// The end time of the last segment on the edge.
    end_time: ?i64 = null,

    /// A histogram that maps the spread of event age when received by consumers.
    /// Age is calculated each time an event is received. Only populated when
    /// *EdgeType* is
    /// `link`.
    received_event_age_histogram: ?[]const HistogramEntry = null,

    /// Identifier of the edge. Unique within a service map.
    reference_id: ?i32 = null,

    /// A histogram that maps the spread of client response times on an edge. Only
    /// populated
    /// for synchronous edges.
    response_time_histogram: ?[]const HistogramEntry = null,

    /// The start time of the first segment on the edge.
    start_time: ?i64 = null,

    /// Response statistics for segments on the edge.
    summary_statistics: ?EdgeStatistics = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .edge_type = "EdgeType",
        .end_time = "EndTime",
        .received_event_age_histogram = "ReceivedEventAgeHistogram",
        .reference_id = "ReferenceId",
        .response_time_histogram = "ResponseTimeHistogram",
        .start_time = "StartTime",
        .summary_statistics = "SummaryStatistics",
    };
};
