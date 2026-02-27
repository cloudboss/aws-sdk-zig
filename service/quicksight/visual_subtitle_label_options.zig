const LongFormatText = @import("long_format_text.zig").LongFormatText;
const Visibility = @import("visibility.zig").Visibility;

/// The subtitle label options for a visual.
pub const VisualSubtitleLabelOptions = struct {
    /// The long text format of the subtitle label, such as plain text or rich text.
    format_text: ?LongFormatText,

    /// The visibility of the subtitle label.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .format_text = "FormatText",
        .visibility = "Visibility",
    };
};
