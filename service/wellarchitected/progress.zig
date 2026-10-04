/// Progress information for a recommendation generation process.
pub const Progress = struct {
    /// The completion percentage of the generation process (0-100).
    completion_percentage: f64,

    /// The number of generation steps that have been completed.
    steps_completed: i32,

    /// The total number of steps in the generation process.
    total_steps: i32,

    pub const json_field_names = .{
        .completion_percentage = "completionPercentage",
        .steps_completed = "stepsCompleted",
        .total_steps = "totalSteps",
    };
};
