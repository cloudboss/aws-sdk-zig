/// This filters by recovery points within the CreatedAfter and CreatedBefore
/// timestamps.
pub const BackupCreationTimeFilter = struct {
    /// This timestamp includes recovery points only created after the specified
    /// time.
    created_after: ?i64 = null,

    /// This timestamp includes recovery points only created before the specified
    /// time.
    created_before: ?i64 = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
    };
};
