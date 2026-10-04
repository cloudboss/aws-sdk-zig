/// Import task summary waves.
pub const ImportTaskSummaryWaves = struct {
    /// Import task summary waves created count.
    created_count: i64 = 0,

    /// Import task summary waves modified count.
    modified_count: i64 = 0,

    pub const json_field_names = .{
        .created_count = "createdCount",
        .modified_count = "modifiedCount",
    };
};
