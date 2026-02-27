const aws = @import("aws");

/// Provides the results of a query that retrieved the data for a standard
/// execution metric that applies to a journey run, and provides information
/// about that query.
pub const JourneyRunExecutionMetricsResponse = struct {
    /// The unique identifier for the application that the metric applies to.
    application_id: []const u8,

    /// The unique identifier for the journey that the metric applies to.
    journey_id: []const u8,

    /// The date and time, in ISO 8601 format, when Amazon Pinpoint last evaluated
    /// the journey run and updated the data for the metric.
    last_evaluated_time: []const u8,

    /// A JSON object that contains the results of the query. For information about
    /// the structure and contents of the results, see the [Standard Amazon Pinpoint
    /// analytics
    /// metrics](https://docs.aws.amazon.com//pinpoint/latest/developerguide/analytics-standard-metrics.html) in the *Amazon Pinpoint Developer Guide*.
    metrics: []const aws.map.StringMapEntry,

    /// The unique identifier for the journey run that the metric applies to.
    run_id: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .journey_id = "JourneyId",
        .last_evaluated_time = "LastEvaluatedTime",
        .metrics = "Metrics",
        .run_id = "RunId",
    };
};
