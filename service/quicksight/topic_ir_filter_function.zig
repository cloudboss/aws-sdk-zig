pub const TopicIRFilterFunction = enum {
    contains,
    exact,
    starts_with,
    ends_with,
    contains_string,
    previous,
    this,
    last,
    next,
    now,

    pub const json_field_names = .{
        .contains = "CONTAINS",
        .exact = "EXACT",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains_string = "CONTAINS_STRING",
        .previous = "PREVIOUS",
        .this = "THIS",
        .last = "LAST",
        .next = "NEXT",
        .now = "NOW",
    };
};
