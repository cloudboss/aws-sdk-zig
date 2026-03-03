/// Statistics about the import progress
pub const ImportStatistics = struct {
    /// The total number of bytes that have been imported to the managed log group.
    bytes_imported: ?i64 = null,

    pub const json_field_names = .{
        .bytes_imported = "bytesImported",
    };
};
