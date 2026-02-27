/// Maps a source column identifier to a target column identifier during
/// transform operations.
pub const DataSetColumnIdMapping = struct {
    /// Source column ID.
    source_column_id: []const u8,

    /// Target column ID.
    target_column_id: []const u8,

    pub const json_field_names = .{
        .source_column_id = "SourceColumnId",
        .target_column_id = "TargetColumnId",
    };
};
