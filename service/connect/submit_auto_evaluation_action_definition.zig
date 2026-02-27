/// Information about the submit automated evaluation action.
pub const SubmitAutoEvaluationActionDefinition = struct {
    /// The identifier of the auto-evaluation enabled form.
    evaluation_form_id: []const u8,

    pub const json_field_names = .{
        .evaluation_form_id = "EvaluationFormId",
    };
};
