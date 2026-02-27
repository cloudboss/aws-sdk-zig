pub const EvaluationFormVersionStatus = enum {
    draft,
    active,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .active = "ACTIVE",
    };
};
