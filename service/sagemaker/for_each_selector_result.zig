/// The result of the selector that identifies an iteration of a ForEach step.
pub const ForEachSelectorResult = struct {
    /// The index of the iteration within the ForEach step.
    index: ?i32 = null,

    /// The name of the step associated with the iteration.
    step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .index = "Index",
        .step_name = "StepName",
    };
};
