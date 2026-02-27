pub const EvaluationType = enum {
    static,
    dynamic,

    pub const json_field_names = .{
        .static = "STATIC",
        .dynamic = "DYNAMIC",
    };
};
