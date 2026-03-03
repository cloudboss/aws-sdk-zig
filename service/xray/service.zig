const HistogramEntry = @import("histogram_entry.zig").HistogramEntry;
const Edge = @import("edge.zig").Edge;
const ServiceStatistics = @import("service_statistics.zig").ServiceStatistics;

/// Information about an application that processed requests, users that made
/// requests, or downstream services,
/// resources, and applications that an application used.
pub const Service = struct {
    /// Identifier of the Amazon Web Services account in which the service runs.
    account_id: ?[]const u8 = null,

    /// A histogram that maps the spread of service durations.
    duration_histogram: ?[]const HistogramEntry = null,

    /// Connections to downstream services.
    edges: ?[]const Edge = null,

    /// The end time of the last segment that the service generated.
    end_time: ?i64 = null,

    /// The canonical name of the service.
    name: ?[]const u8 = null,

    /// A list of names for the service, including the canonical name.
    names: ?[]const []const u8 = null,

    /// Identifier for the service. Unique within the service map.
    reference_id: ?i32 = null,

    /// A histogram that maps the spread of service response times.
    response_time_histogram: ?[]const HistogramEntry = null,

    /// Indicates that the service was the first service to process a request.
    root: ?bool = null,

    /// The start time of the first segment that the service generated.
    start_time: ?i64 = null,

    /// The service's state.
    state: ?[]const u8 = null,

    /// Aggregated statistics for the service.
    summary_statistics: ?ServiceStatistics = null,

    /// The type of service.
    ///
    /// * Amazon Web Services Resource - The type of an Amazon Web Services
    ///   resource. For example, `AWS::EC2::Instance` for an
    /// application running on Amazon EC2 or `AWS::DynamoDB::Table` for an Amazon
    /// DynamoDB table that the
    /// application used.
    ///
    /// * Amazon Web Services Service - The type of an Amazon Web Services service.
    ///   For example, `AWS::DynamoDB`
    /// for downstream calls to Amazon DynamoDB that didn't target a specific table.
    ///
    /// * `client` - Represents the clients that sent requests to a root
    /// service.
    ///
    /// * `remote` - A downstream service of indeterminate type.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .duration_histogram = "DurationHistogram",
        .edges = "Edges",
        .end_time = "EndTime",
        .name = "Name",
        .names = "Names",
        .reference_id = "ReferenceId",
        .response_time_histogram = "ResponseTimeHistogram",
        .root = "Root",
        .start_time = "StartTime",
        .state = "State",
        .summary_statistics = "SummaryStatistics",
        .@"type" = "Type",
    };
};
