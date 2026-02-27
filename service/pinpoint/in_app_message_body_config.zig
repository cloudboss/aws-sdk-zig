const Alignment = @import("alignment.zig").Alignment;

/// Text config for Message Body.
pub const InAppMessageBodyConfig = struct {
    /// The alignment of the text. Valid values: LEFT, CENTER, RIGHT.
    alignment: Alignment,

    /// Message Body.
    body: []const u8,

    /// The text color.
    text_color: []const u8,

    pub const json_field_names = .{
        .alignment = "Alignment",
        .body = "Body",
        .text_color = "TextColor",
    };
};
