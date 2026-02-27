pub const RelationalDatabasePasswordVersion = enum {
    current,
    previous,
    pending,

    pub const json_field_names = .{
        .current = "CURRENT",
        .previous = "PREVIOUS",
        .pending = "PENDING",
    };
};
