const SchedulingMaxPriorityOverride = @import("scheduling_max_priority_override.zig").SchedulingMaxPriorityOverride;
const SchedulingMinPriorityOverride = @import("scheduling_min_priority_override.zig").SchedulingMinPriorityOverride;

/// Configuration for weighted balanced scheduling. Workers are assigned to jobs
/// based on a weighted formula:
///
/// `weight = (priority * priorityWeight) + (errors * errorWeight) +
/// ((currentTime - submissionTime) * submissionTimeWeight) + ((renderingTasks -
/// renderingTaskBuffer) * renderingTaskWeight)`
///
/// The job with the highest calculated weight is scheduled first. Workers are
/// distributed evenly amongst jobs with the same weight.
pub const WeightedBalancedSchedulingConfiguration = struct {
    /// The weight applied to the number of errors on a job. A negative value means
    /// jobs without errors are scheduled first. A value of `0` means errors are
    /// ignored. The default value is `-10.0`.
    error_weight: f64 = -10.0,

    /// Overrides the weighted scheduling formula for jobs at the maximum priority
    /// (100). When set, jobs with priority 100 are always scheduled first
    /// regardless of their calculated weight. When absent, maximum priority jobs
    /// use the standard weighted formula.
    max_priority_override: ?SchedulingMaxPriorityOverride = null,

    /// Overrides the weighted scheduling formula for jobs at the minimum priority
    /// (0). When set, jobs with priority 0 are always scheduled last regardless of
    /// their calculated weight. When absent, minimum priority jobs use the standard
    /// weighted formula.
    min_priority_override: ?SchedulingMinPriorityOverride = null,

    /// The weight applied to job priority in the scheduling formula. Higher values
    /// give more influence to job priority. A value of `0` means priority is
    /// ignored. The default value is `100.0`.
    priority_weight: f64 = 100.0,

    /// The rendering task buffer is subtracted from the number of rendering tasks
    /// before applying the rendering task weight. This creates a stickiness effect
    /// where workers prefer to stay with their current job. Higher values make
    /// workers stickier. The default value is `1`. The buffer is only applied in
    /// the weight calculation for a job if the worker is currently assigned to that
    /// job.
    rendering_task_buffer: i32 = 1,

    /// The weight applied to the number of tasks currently rendering on a job. A
    /// negative value means jobs that are not already rendering are scheduled next.
    /// A value of `0` means the rendering state is ignored. The default value is
    /// `-100.0`.
    rendering_task_weight: f64 = -100.0,

    /// The weight applied to job submission time. A positive value means earlier
    /// jobs are scheduled first. A value of `0` means submission time is ignored.
    /// The default value is `3.0`.
    submission_time_weight: f64 = 3.0,

    pub const json_field_names = .{
        .error_weight = "errorWeight",
        .max_priority_override = "maxPriorityOverride",
        .min_priority_override = "minPriorityOverride",
        .priority_weight = "priorityWeight",
        .rendering_task_buffer = "renderingTaskBuffer",
        .rendering_task_weight = "renderingTaskWeight",
        .submission_time_weight = "submissionTimeWeight",
    };
};
