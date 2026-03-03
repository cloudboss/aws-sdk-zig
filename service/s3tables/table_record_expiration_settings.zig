/// The record expiration setting that specifies when records expire and are
/// automatically removed from a table.
pub const TableRecordExpirationSettings = struct {
    /// If you enable record expiration for a table, you can specify the number of
    /// days to retain your table records. For example, to retain your table records
    /// for one year, set this value to `365`.
    days: ?i32 = null,

    pub const json_field_names = .{
        .days = "days",
    };
};
