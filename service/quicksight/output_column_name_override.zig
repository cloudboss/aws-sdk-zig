/// Specifies a mapping to override the name of an output column from a
/// transform operation.
pub const OutputColumnNameOverride = struct {
    /// The new name to assign to the column in the output.
    output_column_name: []const u8,

    /// The original name of the column from the source transform operation.
    source_column_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_column_name = "OutputColumnName",
        .source_column_name = "SourceColumnName",
    };
};
