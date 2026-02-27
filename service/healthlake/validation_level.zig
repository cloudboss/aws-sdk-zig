pub const ValidationLevel = enum {
    strict,
    structure_only,
    minimal,

    pub const json_field_names = .{
        .strict = "STRICT",
        .structure_only = "STRUCTURE_ONLY",
        .minimal = "MINIMAL",
    };
};
