pub const VoteValue = enum {
    yes,
    no,

    pub const json_field_names = .{
        .yes = "YES",
        .no = "NO",
    };
};
