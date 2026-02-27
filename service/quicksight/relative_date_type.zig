pub const RelativeDateType = enum {
    previous,
    this,
    last,
    now,
    next,

    pub const json_field_names = .{
        .previous = "PREVIOUS",
        .this = "THIS",
        .last = "LAST",
        .now = "NOW",
        .next = "NEXT",
    };
};
