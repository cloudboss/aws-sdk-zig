const AbortCriteriaAction = @import("abort_criteria_action.zig").AbortCriteriaAction;
const AbortCriteriaFailureType = @import("abort_criteria_failure_type.zig").AbortCriteriaFailureType;

/// Structure representing one abort config criteria.
pub const AbortConfigCriteria = struct {
    /// The action taken by the abort configuration.
    action: ?AbortCriteriaAction,

    /// Over-the-air (OTA) task abort criteria failure type.
    failure_type: ?AbortCriteriaFailureType,

    /// The minimum number of things that must receive task execution notifications
    /// before the task can be aborted.
    min_number_of_executed_things: ?i32,

    /// The minimum percentage of over-the-air (OTA) task execution failures that
    /// must occur to initiate the last abort.
    threshold_percentage: ?f64,

    pub const json_field_names = .{
        .action = "Action",
        .failure_type = "FailureType",
        .min_number_of_executed_things = "MinNumberOfExecutedThings",
        .threshold_percentage = "ThresholdPercentage",
    };
};
