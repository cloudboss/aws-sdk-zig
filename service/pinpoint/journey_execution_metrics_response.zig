const aws = @import("aws");

/// Provides the results of a query that retrieved the data for a standard
/// execution metric that applies to a journey, and provides information about
/// that query.
pub const JourneyExecutionMetricsResponse = struct {
    /// The unique identifier for the application that the metric applies to.
    application_id: []const u8,

    /// The unique identifier for the journey that the metric applies to.
    journey_id: []const u8,

    /// The date and time, in ISO 8601 format, when Amazon Pinpoint last evaluated
    /// the journey and updated the data for the metric.
    last_evaluated_time: []const u8,

    /// A JSON object that contains the results of the query. For information about
    /// the structure and contents of the results, see the [Amazon Pinpoint
    /// Developer
    /// Guide](https://docs.aws.amazon.com//pinpoint/latest/developerguide/analytics-standard-metrics.html).
    metrics: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .journey_id = "JourneyId",
        .last_evaluated_time = "LastEvaluatedTime",
        .metrics = "Metrics",
    };
};
