const ColumnTag = @import("column_tag.zig").ColumnTag;

/// A transform operation that tags a column with additional information.
pub const TagColumnOperation = struct {
    /// The column that this operation acts on.
    column_name: []const u8,

    /// The dataset column tag, currently only used for geospatial type tagging.
    ///
    /// This is not tags for the Amazon Web Services tagging feature.
    tags: []const ColumnTag,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .tags = "Tags",
    };
};
