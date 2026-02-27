pub const AcceptCodeValidation = enum {
    ignore,
    enforce,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .enforce = "ENFORCE",
    };
};
