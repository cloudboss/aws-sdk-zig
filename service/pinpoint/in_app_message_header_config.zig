const Alignment = @import("alignment.zig").Alignment;

/// Text config for Message Header.
pub const InAppMessageHeaderConfig = struct {
    /// The alignment of the text. Valid values: LEFT, CENTER, RIGHT.
    alignment: Alignment,

    /// Message Header.
    header: []const u8,

    /// The text color.
    text_color: []const u8,

    pub const json_field_names = .{
        .alignment = "Alignment",
        .header = "Header",
        .text_color = "TextColor",
    };
};
