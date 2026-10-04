/// A mapping between a step identifier and its alias in a flow.
pub const StepAliasMapping = struct {
    /// The alias for the step.
    step_alias: []const u8,

    /// The unique identifier of the step.
    step_id: []const u8,

    pub const json_field_names = .{
        .step_alias = "StepAlias",
        .step_id = "StepId",
    };
};
