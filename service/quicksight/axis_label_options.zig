const AxisLabelReferenceOptions = @import("axis_label_reference_options.zig").AxisLabelReferenceOptions;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;

/// The label options for a chart axis. You must specify the field that the
/// label is targeted to.
pub const AxisLabelOptions = struct {
    /// The options that indicate which field the label belongs to.
    apply_to: ?AxisLabelReferenceOptions,

    /// The text for the axis label.
    custom_label: ?[]const u8,

    /// The font configuration of the axis label.
    font_configuration: ?FontConfiguration,

    pub const json_field_names = .{
        .apply_to = "ApplyTo",
        .custom_label = "CustomLabel",
        .font_configuration = "FontConfiguration",
    };
};
