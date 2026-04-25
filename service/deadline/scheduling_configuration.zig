const PriorityBalancedSchedulingConfiguration = @import("priority_balanced_scheduling_configuration.zig").PriorityBalancedSchedulingConfiguration;
const PriorityFifoSchedulingConfiguration = @import("priority_fifo_scheduling_configuration.zig").PriorityFifoSchedulingConfiguration;
const WeightedBalancedSchedulingConfiguration = @import("weighted_balanced_scheduling_configuration.zig").WeightedBalancedSchedulingConfiguration;

/// The scheduling configuration for a queue. Defines the strategy used to
/// assign workers to jobs.
pub const SchedulingConfiguration = union(enum) {
    /// Workers are distributed evenly across all jobs at the highest priority
    /// level. When workers cannot be evenly divided, the extra workers are assigned
    /// to the jobs submitted earliest. If a job has fewer remaining tasks than its
    /// share of workers, the surplus workers are redistributed to other jobs at the
    /// same priority level.
    priority_balanced: ?PriorityBalancedSchedulingConfiguration,
    /// Workers are assigned to the highest-priority job first. When multiple jobs
    /// share the same priority, the job submitted earliest receives workers first.
    /// This is the default scheduling configuration for new queues.
    priority_fifo: ?PriorityFifoSchedulingConfiguration,
    /// Workers are assigned to jobs based on a weighted formula that considers job
    /// priority, error count, submission time, and the number of tasks currently
    /// rendering. Each factor has a configurable weight that determines its
    /// influence on scheduling decisions.
    weighted_balanced: ?WeightedBalancedSchedulingConfiguration,

    pub const json_field_names = .{
        .priority_balanced = "priorityBalanced",
        .priority_fifo = "priorityFifo",
        .weighted_balanced = "weightedBalanced",
    };
};
