pub const EvaluationMode = enum {
    detective,
    proactive,

    pub const json_field_names = .{
        .detective = "DETECTIVE",
        .proactive = "PROACTIVE",
    };
};
