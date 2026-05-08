/// A reference to a child function within a `SEQUENTIAL_EXECUTOR` function.
pub const FunctionRef = struct {
    /// The identifier of the child function to execute in this step.
    function_id: ?[]const u8 = null,

    /// An optional expression that evaluates to a boolean. MediaTailor evaluates
    /// this expression immediately before running the step, using the accumulated
    /// state at that point in the sequence. If the expression evaluates to `false`,
    /// MediaTailor skips the step and moves to the next one. If omitted, the step
    /// always runs.
    run_condition: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_id = "FunctionId",
        .run_condition = "RunCondition",
    };
};
