/// Defines a mapping.
pub const MappingEntry = struct {
    /// The source path.
    source_path: ?[]const u8,

    /// The name of the source table.
    source_table: ?[]const u8,

    /// The source type.
    source_type: ?[]const u8,

    /// The target path.
    target_path: ?[]const u8,

    /// The target table.
    target_table: ?[]const u8,

    /// The target type.
    target_type: ?[]const u8,

    pub const json_field_names = .{
        .source_path = "SourcePath",
        .source_table = "SourceTable",
        .source_type = "SourceType",
        .target_path = "TargetPath",
        .target_table = "TargetTable",
        .target_type = "TargetType",
    };
};
