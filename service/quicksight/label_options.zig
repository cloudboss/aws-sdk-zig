const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const Visibility = @import("visibility.zig").Visibility;

/// The share label options for the labels.
pub const LabelOptions = struct {
    /// The text for the label.
    custom_label: ?[]const u8 = null,

    /// The font configuration of the label.
    font_configuration: ?FontConfiguration = null,

    /// Determines whether or not the label is visible.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .font_configuration = "FontConfiguration",
        .visibility = "Visibility",
    };
};
