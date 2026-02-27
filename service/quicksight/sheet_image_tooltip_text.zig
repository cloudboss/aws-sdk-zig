/// The text that appears in the sheet image tooltip.
pub const SheetImageTooltipText = struct {
    /// The plain text format.
    plain_text: ?[]const u8,

    pub const json_field_names = .{
        .plain_text = "PlainText",
    };
};
