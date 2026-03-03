/// Metadata that contains a description for a column.
pub const ColumnDescription = struct {
    /// The text of a description for a column.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "Text",
    };
};
