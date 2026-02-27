pub const EvaluationMethod = enum {
    batch,
    serial,

    pub const json_field_names = .{
        .batch = "BATCH",
        .serial = "SERIAL",
    };
};
