/// A step selected to run in selective execution mode.
pub const SelectedStep = struct {
    /// The name of the pipeline step.
    step_name: []const u8,

    pub const json_field_names = .{
        .step_name = "StepName",
    };
};
