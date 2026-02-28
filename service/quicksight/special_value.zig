pub const SpecialValue = enum {
    empty,
    @"null",
    other,

    pub const json_field_names = .{
        .empty = "EMPTY",
        .@"null" = "NULL",
        .other = "OTHER",
    };
};
