pub const EvaluationFormMultiSelectQuestionDisplayMode = enum {
    dropdown,
    checkbox,

    pub const json_field_names = .{
        .dropdown = "DROPDOWN",
        .checkbox = "CHECKBOX",
    };
};
