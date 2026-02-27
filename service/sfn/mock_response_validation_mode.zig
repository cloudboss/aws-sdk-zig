pub const MockResponseValidationMode = enum {
    strict,
    present,
    none,

    pub const json_field_names = .{
        .strict = "STRICT",
        .present = "PRESENT",
        .none = "NONE",
    };
};
