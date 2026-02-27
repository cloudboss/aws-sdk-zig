pub const EvaluationType = enum {
    summary,
    computed,

    pub const json_field_names = .{
        .summary = "SUMMARY",
        .computed = "COMPUTED",
    };
};
