pub const FixAvailable = enum {
    yes,
    no,
    partial,

    pub const json_field_names = .{
        .yes = "YES",
        .no = "NO",
        .partial = "PARTIAL",
    };
};
