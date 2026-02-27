/// Import task summary applications.
pub const ImportTaskSummaryApplications = struct {
    /// Import task summary applications created count.
    created_count: i64 = 0,

    /// Import task summary applications modified count.
    modified_count: i64 = 0,

    pub const json_field_names = .{
        .created_count = "createdCount",
        .modified_count = "modifiedCount",
    };
};
