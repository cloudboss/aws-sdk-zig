/// Configuration for priority balanced scheduling. Workers are distributed
/// evenly across all jobs at the highest priority level.
pub const PriorityBalancedSchedulingConfiguration = struct {
    /// The rendering task buffer controls worker stickiness. A worker only switches
    /// from its current job to another job at the same priority if the other job
    /// has fewer rendering tasks by more than this buffer value. Higher values make
    /// workers stickier to their current jobs. The default value is `1`.
    rendering_task_buffer: i32 = 1,

    pub const json_field_names = .{
        .rendering_task_buffer = "renderingTaskBuffer",
    };
};
