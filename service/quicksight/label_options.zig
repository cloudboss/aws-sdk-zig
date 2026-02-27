const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const Visibility = @import("visibility.zig").Visibility;

/// The share label options for the labels.
pub const LabelOptions = struct {
    /// The text for the label.
    custom_label: ?[]const u8,

    /// The font configuration of the label.
    font_configuration: ?FontConfiguration,

    /// Determines whether or not the label is visible.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .font_configuration = "FontConfiguration",
        .visibility = "Visibility",
    };
};
