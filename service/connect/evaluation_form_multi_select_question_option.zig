/// An option for a multi-select question in an evaluation form.
pub const EvaluationFormMultiSelectQuestionOption = struct {
    /// Reference identifier for this option.
    ref_id: []const u8,

    /// Display text for this option.
    text: []const u8,

    pub const json_field_names = .{
        .ref_id = "RefId",
        .text = "Text",
    };
};
