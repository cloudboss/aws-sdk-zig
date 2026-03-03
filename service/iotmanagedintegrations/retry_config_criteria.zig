const RetryCriteriaFailureType = @import("retry_criteria_failure_type.zig").RetryCriteriaFailureType;

/// Structure representing one retry config criteria.
pub const RetryConfigCriteria = struct {
    /// Over-the-air (OTA) retry criteria failure type.
    failure_type: ?RetryCriteriaFailureType = null,

    /// The number of retries allowed for a failure type for the over-the-air (OTA)
    /// task.
    min_number_of_retries: ?i32 = null,

    pub const json_field_names = .{
        .failure_type = "FailureType",
        .min_number_of_retries = "MinNumberOfRetries",
    };
};
