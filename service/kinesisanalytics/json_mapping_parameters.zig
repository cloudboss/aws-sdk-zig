/// Provides additional mapping information when JSON is the record format on
/// the streaming source.
pub const JSONMappingParameters = struct {
    /// Path to the top-level parent that contains the records.
    record_row_path: []const u8,

    pub const json_field_names = .{
        .record_row_path = "RecordRowPath",
    };
};
