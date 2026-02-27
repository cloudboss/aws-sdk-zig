const ShortFormatText = @import("short_format_text.zig").ShortFormatText;
const Visibility = @import("visibility.zig").Visibility;

/// The title label options for a visual.
pub const VisualTitleLabelOptions = struct {
    /// The short text format of the title label, such as plain text or rich text.
    format_text: ?ShortFormatText,

    /// The visibility of the title label.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .format_text = "FormatText",
        .visibility = "Visibility",
    };
};
