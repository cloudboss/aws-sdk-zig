const Step = @import("step.zig").Step;

/// Configuration for steps that should be executed in parallel during a Region
/// switch.
pub const ParallelExecutionBlockConfiguration = struct {
    /// The steps for a parallel execution block.
    steps: []const Step,

    pub const json_field_names = .{
        .steps = "steps",
    };
};
