pub const EvaluationFormSingleSelectQuestionDisplayMode = enum {
    dropdown,
    radio,

    pub const json_field_names = .{
        .dropdown = "DROPDOWN",
        .radio = "RADIO",
    };
};
