pub const TableOptimizerType = enum {
    compaction,
    retention,
    orphan_file_deletion,

    pub const json_field_names = .{
        .compaction = "COMPACTION",
        .retention = "RETENTION",
        .orphan_file_deletion = "ORPHAN_FILE_DELETION",
    };
};
