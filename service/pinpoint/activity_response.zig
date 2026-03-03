const aws = @import("aws");

/// Provides information about an activity that was performed by a campaign.
pub const ActivityResponse = struct {
    /// The unique identifier for the application that the campaign applies to.
    application_id: []const u8,

    /// The unique identifier for the campaign that the activity applies to.
    campaign_id: []const u8,

    /// The actual time, in ISO 8601 format, when the activity was marked CANCELLED
    /// or COMPLETED.
    end: ?[]const u8 = null,

    /// A JSON object that contains metrics relating to the campaign execution for
    /// this campaign activity. For information about the structure and contents of
    /// the results, see [Standard Amazon Pinpoint analytics
    /// metrics](https://docs.aws.amazon.com//pinpoint/latest/developerguide/analytics-standard-metrics.html) in the *Amazon Pinpoint Developer Guide*.
    execution_metrics: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier for the activity.
    id: []const u8,

    /// Specifies whether the activity succeeded. Possible values are SUCCESS and
    /// FAIL.
    result: ?[]const u8 = null,

    /// The scheduled start time, in ISO 8601 format, for the activity.
    scheduled_start: ?[]const u8 = null,

    /// The actual start time, in ISO 8601 format, of the activity.
    start: ?[]const u8 = null,

    /// The current status of the activity. Possible values are: PENDING,
    /// INITIALIZING, RUNNING, PAUSED, CANCELLED, and COMPLETED.
    state: ?[]const u8 = null,

    /// The total number of endpoints that the campaign successfully delivered
    /// messages to.
    successful_endpoint_count: ?i32 = null,

    /// The total number of time zones that were completed.
    timezones_completed_count: ?i32 = null,

    /// The total number of unique time zones that are in the segment for the
    /// campaign.
    timezones_total_count: ?i32 = null,

    /// The total number of endpoints that the campaign attempted to deliver
    /// messages to.
    total_endpoint_count: ?i32 = null,

    /// The unique identifier for the campaign treatment that the activity applies
    /// to. A treatment is a variation of a campaign that's used for A/B testing of
    /// a campaign.
    treatment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .campaign_id = "CampaignId",
        .end = "End",
        .execution_metrics = "ExecutionMetrics",
        .id = "Id",
        .result = "Result",
        .scheduled_start = "ScheduledStart",
        .start = "Start",
        .state = "State",
        .successful_endpoint_count = "SuccessfulEndpointCount",
        .timezones_completed_count = "TimezonesCompletedCount",
        .timezones_total_count = "TimezonesTotalCount",
        .total_endpoint_count = "TotalEndpointCount",
        .treatment_id = "TreatmentId",
    };
};
