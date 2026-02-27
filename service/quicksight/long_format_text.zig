/// The text format for a subtitle.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const LongFormatText = struct {
    /// Plain text format.
    plain_text: ?[]const u8,

    /// Rich text. Examples of rich text include bold, underline, and italics.
    rich_text: ?[]const u8,

    pub const json_field_names = .{
        .plain_text = "PlainText",
        .rich_text = "RichText",
    };
};
