pub const DQCompositeRuleEvaluationMethod = enum {
    column,
    row,

    pub const json_field_names = .{
        .column = "COLUMN",
        .row = "ROW",
    };
};
