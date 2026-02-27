pub const QueryResult = enum {
    present,
    absent,

    pub const json_field_names = .{
        .present = "PRESENT",
        .absent = "ABSENT",
    };
};
