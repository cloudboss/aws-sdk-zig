/// Contains details about the unreferenced file removal settings for an Iceberg
/// table bucket.
pub const IcebergUnreferencedFileRemovalSettings = struct {
    /// The number of days an object has to be non-current before it is deleted.
    non_current_days: ?i32 = null,

    /// The number of days an object has to be unreferenced before it is marked as
    /// non-current.
    unreferenced_days: ?i32 = null,

    pub const json_field_names = .{
        .non_current_days = "nonCurrentDays",
        .unreferenced_days = "unreferencedDays",
    };
};
