const RangeConstraint = @import("range_constraint.zig").RangeConstraint;

/// Defines how a step parameter range should be divided into chunks.
pub const StepParameterChunks = struct {
    /// The number of tasks to combine into a single chunk by default.
    default_task_count: i32,

    /// Specifies whether the chunked ranges must be contiguous or can have gaps
    /// between them.
    range_constraint: RangeConstraint,

    /// The number of seconds to aim for when forming chunks.
    target_runtime_seconds: ?i32 = null,

    pub const json_field_names = .{
        .default_task_count = "defaultTaskCount",
        .range_constraint = "rangeConstraint",
        .target_runtime_seconds = "targetRuntimeSeconds",
    };
};
