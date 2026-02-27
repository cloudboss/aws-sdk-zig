pub const ResolverKind = enum {
    unit,
    pipeline,

    pub const json_field_names = .{
        .unit = "UNIT",
        .pipeline = "PIPELINE",
    };
};
