/// A detailed status of the parent step.
pub const ParentStepDetails = struct {
    /// The name of the automation action.
    action: ?[]const u8 = null,

    /// The current repetition of the loop represented by an integer.
    iteration: ?i32 = null,

    /// The current value of the specified iterator in the loop.
    iterator_value: ?[]const u8 = null,

    /// The unique ID of a step execution.
    step_execution_id: ?[]const u8 = null,

    /// The name of the step.
    step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .iteration = "Iteration",
        .iterator_value = "IteratorValue",
        .step_execution_id = "StepExecutionId",
        .step_name = "StepName",
    };
};
