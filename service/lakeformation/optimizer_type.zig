pub const OptimizerType = enum {
    compaction,
    garbage_collection,
    generic,

    pub const json_field_names = .{
        .compaction = "COMPACTION",
        .garbage_collection = "GARBAGE_COLLECTION",
        .generic = "GENERIC",
    };
};
