/// The title format text configuration for a sheet control. This is a tagged
/// union type. Specify either `PlainText` or `RichText`, but not both.
pub const ControlTitleFormatText = struct {
    /// The plain text format of the title text.
    plain_text: ?[]const u8 = null,

    /// The rich text format of the title text.
    rich_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .plain_text = "PlainText",
        .rich_text = "RichText",
    };
};
