const aws = @import("aws");

/// Provides the results of a query that retrieved the data for a standard
/// execution metric that applies to a journey activity for a particular journey
/// run, and provides information about that query.
pub const JourneyRunExecutionActivityMetricsResponse = struct {
    /// The type of activity that the metric applies to. Possible values are:
    ///
    /// * CONDITIONAL_SPLIT – For a yes/no split activity, which is an activity that
    ///   sends participants down one of two paths in a journey.
    /// * HOLDOUT – For a holdout activity, which is an activity that stops a
    ///   journey for a specified percentage of participants.
    /// * MESSAGE – For an email activity, which is an activity that sends an email
    ///   message to participants.
    /// * MULTI_CONDITIONAL_SPLIT – For a multivariate split activity, which is an
    ///   activity that sends participants down one of as many as five paths in a
    ///   journey.
    /// * RANDOM_SPLIT – For a random split activity, which is an activity that
    ///   sends specified percentages of participants down one of as many as five
    ///   paths in a journey.
    /// * WAIT – For a wait activity, which is an activity that waits for a certain
    ///   amount of time or until a specific date and time before moving
    ///   participants to the next activity in a journey.
    activity_type: []const u8,

    /// The unique identifier for the application that the metric applies to.
    application_id: []const u8,

    /// The unique identifier for the activity that the metric applies to.
    journey_activity_id: []const u8,

    /// The unique identifier for the journey that the metric applies to.
    journey_id: []const u8,

    /// The date and time, in ISO 8601 format, when Amazon Pinpoint last evaluated
    /// the execution status of the activity for this journey run and updated the
    /// data for the metric.
    last_evaluated_time: []const u8,

    /// A JSON object that contains the results of the query. For information about
    /// the structure and contents of the results, see see [Standard Amazon Pinpoint
    /// analytics
    /// metrics](https://docs.aws.amazon.com//pinpoint/latest/developerguide/analytics-standard-metrics.html) in the *Amazon Pinpoint Developer Guide*.
    metrics: []const aws.map.StringMapEntry,

    /// The unique identifier for the journey run that the metric applies to.
    run_id: []const u8,

    pub const json_field_names = .{
        .activity_type = "ActivityType",
        .application_id = "ApplicationId",
        .journey_activity_id = "JourneyActivityId",
        .journey_id = "JourneyId",
        .last_evaluated_time = "LastEvaluatedTime",
        .metrics = "Metrics",
        .run_id = "RunId",
    };
};
