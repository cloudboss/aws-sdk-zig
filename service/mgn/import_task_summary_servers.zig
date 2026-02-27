/// Import task summary servers.
pub const ImportTaskSummaryServers = struct {
    /// Import task summary servers created count.
    created_count: i64 = 0,

    /// Import task summary servers modified count.
    modified_count: i64 = 0,

    pub const json_field_names = .{
        .created_count = "createdCount",
        .modified_count = "modifiedCount",
    };
};
