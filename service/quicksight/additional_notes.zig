/// Additional notes that provide supplementary context for a column.
pub const AdditionalNotes = struct {
    /// The additional notes text.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "Text",
    };
};
