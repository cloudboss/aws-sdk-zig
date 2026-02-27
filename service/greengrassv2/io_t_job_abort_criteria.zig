const IoTJobAbortAction = @import("io_t_job_abort_action.zig").IoTJobAbortAction;
const IoTJobExecutionFailureType = @import("io_t_job_execution_failure_type.zig").IoTJobExecutionFailureType;

/// Contains criteria that define when and how to cancel a job.
///
/// The deployment stops if the following conditions are true:
///
/// * The number of things that receive the deployment exceeds the
/// `minNumberOfExecutedThings`.
///
/// * The percentage of failures with type `failureType` exceeds the
/// `thresholdPercentage`.
pub const IoTJobAbortCriteria = struct {
    /// The action to perform when the criteria are met.
    action: IoTJobAbortAction,

    /// The type of job deployment failure that can cancel a job.
    failure_type: IoTJobExecutionFailureType,

    /// The minimum number of things that receive the configuration before the job
    /// can
    /// cancel.
    min_number_of_executed_things: i32,

    /// The minimum percentage of `failureType` failures that occur before the job
    /// can
    /// cancel.
    ///
    /// This parameter supports up to two digits after the decimal (for example, you
    /// can specify
    /// `10.9` or `10.99`, but not `10.999`).
    threshold_percentage: f64 = 0,

    pub const json_field_names = .{
        .action = "action",
        .failure_type = "failureType",
        .min_number_of_executed_things = "minNumberOfExecutedThings",
        .threshold_percentage = "thresholdPercentage",
    };
};
