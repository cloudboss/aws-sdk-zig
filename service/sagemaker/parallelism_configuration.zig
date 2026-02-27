/// Configuration that controls the parallelism of the pipeline. By default, the
/// parallelism configuration specified applies to all executions of the
/// pipeline unless overridden.
pub const ParallelismConfiguration = struct {
    /// The max number of steps that can be executed in parallel.
    max_parallel_execution_steps: i32,

    pub const json_field_names = .{
        .max_parallel_execution_steps = "MaxParallelExecutionSteps",
    };
};
