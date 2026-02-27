pub const StatisticEvaluationLevel = enum {
    dataset,
    column,
    multicolumn,

    pub const json_field_names = .{
        .dataset = "DATASET",
        .column = "COLUMN",
        .multicolumn = "MULTICOLUMN",
    };
};
