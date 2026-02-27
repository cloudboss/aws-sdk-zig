pub const FlattenedElement = enum {
    first,
    last,

    pub const json_field_names = .{
        .first = "FIRST",
        .last = "LAST",
    };
};
