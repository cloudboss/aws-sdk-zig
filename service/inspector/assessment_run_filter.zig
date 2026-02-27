const TimestampRange = @import("timestamp_range.zig").TimestampRange;
const DurationRange = @import("duration_range.zig").DurationRange;
const AssessmentRunState = @import("assessment_run_state.zig").AssessmentRunState;

/// Used as the request parameter in the ListAssessmentRuns
/// action.
pub const AssessmentRunFilter = struct {
    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must inclusively match any value between the specified minimum and
    /// maximum values
    /// of the **completedAt** property of the AssessmentRun data type.
    completion_time_range: ?TimestampRange,

    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must inclusively match any value between the specified minimum and
    /// maximum values
    /// of the **durationInSeconds** property of the AssessmentRun data type.
    duration_range: ?DurationRange,

    /// For a record to match a filter, an explicit value or a string containing a
    /// wildcard
    /// that is specified for this data type property must match the value of the
    /// **assessmentRunName** property of the AssessmentRun
    /// data type.
    name_pattern: ?[]const u8,

    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must be contained in the list of values of the **rulesPackages**
    /// property of the AssessmentRun data
    /// type.
    rules_package_arns: ?[]const []const u8,

    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must inclusively match any value between the specified minimum and
    /// maximum values
    /// of the **startTime** property of the AssessmentRun data type.
    start_time_range: ?TimestampRange,

    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must match the **stateChangedAt** property of the
    /// AssessmentRun data type.
    state_change_time_range: ?TimestampRange,

    /// For a record to match a filter, one of the values specified for this data
    /// type
    /// property must be the exact match of the value of the **assessmentRunState**
    /// property of the AssessmentRun data
    /// type.
    states: ?[]const AssessmentRunState,

    pub const json_field_names = .{
        .completion_time_range = "completionTimeRange",
        .duration_range = "durationRange",
        .name_pattern = "namePattern",
        .rules_package_arns = "rulesPackageArns",
        .start_time_range = "startTimeRange",
        .state_change_time_range = "stateChangeTimeRange",
        .states = "states",
    };
};
