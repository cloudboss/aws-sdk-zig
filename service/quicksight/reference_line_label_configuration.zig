const ReferenceLineCustomLabelConfiguration = @import("reference_line_custom_label_configuration.zig").ReferenceLineCustomLabelConfiguration;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const ReferenceLineLabelHorizontalPosition = @import("reference_line_label_horizontal_position.zig").ReferenceLineLabelHorizontalPosition;
const ReferenceLineValueLabelConfiguration = @import("reference_line_value_label_configuration.zig").ReferenceLineValueLabelConfiguration;
const ReferenceLineLabelVerticalPosition = @import("reference_line_label_vertical_position.zig").ReferenceLineLabelVerticalPosition;

/// The label configuration of a reference line.
pub const ReferenceLineLabelConfiguration = struct {
    /// The custom label configuration of the label in a reference line.
    custom_label_configuration: ?ReferenceLineCustomLabelConfiguration,

    /// The font color configuration of the label in a reference line.
    font_color: ?[]const u8,

    /// The font configuration of the label in a reference line.
    font_configuration: ?FontConfiguration,

    /// The horizontal position configuration of the label in a reference line.
    /// Choose one of
    /// the following options:
    ///
    /// * `LEFT`
    ///
    /// * `CENTER`
    ///
    /// * `RIGHT`
    horizontal_position: ?ReferenceLineLabelHorizontalPosition,

    /// The value label configuration of the label in a reference line.
    value_label_configuration: ?ReferenceLineValueLabelConfiguration,

    /// The vertical position configuration of the label in a reference line. Choose
    /// one of the following options:
    ///
    /// * `ABOVE`
    ///
    /// * `BELOW`
    vertical_position: ?ReferenceLineLabelVerticalPosition,

    pub const json_field_names = .{
        .custom_label_configuration = "CustomLabelConfiguration",
        .font_color = "FontColor",
        .font_configuration = "FontConfiguration",
        .horizontal_position = "HorizontalPosition",
        .value_label_configuration = "ValueLabelConfiguration",
        .vertical_position = "VerticalPosition",
    };
};
