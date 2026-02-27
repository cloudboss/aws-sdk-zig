pub const StorageType = enum {
    standard,
    in_memory,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .in_memory = "IN_MEMORY",
    };
};
