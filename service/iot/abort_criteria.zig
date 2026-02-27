const AbortAction = @import("abort_action.zig").AbortAction;
const JobExecutionFailureType = @import("job_execution_failure_type.zig").JobExecutionFailureType;

/// The criteria that determine when and how a job abort takes place.
pub const AbortCriteria = struct {
    /// The type of job action to take to initiate the job abort.
    action: AbortAction,

    /// The type of job execution failures that can initiate a job abort.
    failure_type: JobExecutionFailureType,

    /// The minimum number of things which must receive job execution notifications
    /// before
    /// the job can be aborted.
    min_number_of_executed_things: i32,

    /// The minimum percentage of job execution failures that must occur to initiate
    /// the
    /// job abort.
    ///
    /// Amazon Web Services IoT Core supports up to two digits after the decimal
    /// (for example, 10.9 and 10.99,
    /// but not 10.999).
    threshold_percentage: f64,

    pub const json_field_names = .{
        .action = "action",
        .failure_type = "failureType",
        .min_number_of_executed_things = "minNumberOfExecutedThings",
        .threshold_percentage = "thresholdPercentage",
    };
};
