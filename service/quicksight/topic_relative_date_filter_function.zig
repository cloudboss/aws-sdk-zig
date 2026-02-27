pub const TopicRelativeDateFilterFunction = enum {
    previous,
    this,
    last,
    next,
    now,

    pub const json_field_names = .{
        .previous = "PREVIOUS",
        .this = "THIS",
        .last = "LAST",
        .next = "NEXT",
        .now = "NOW",
    };
};
