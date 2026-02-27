pub const DetailLevel = enum {
    brief,
    detailed,

    pub const json_field_names = .{
        .brief = "BRIEF",
        .detailed = "DETAILED",
    };
};
