const NumericFormatConfiguration = @import("numeric_format_configuration.zig").NumericFormatConfiguration;
const ReferenceLineValueLabelRelativePosition = @import("reference_line_value_label_relative_position.zig").ReferenceLineValueLabelRelativePosition;

/// The value label configuration of the label in a reference line.
pub const ReferenceLineValueLabelConfiguration = struct {
    /// The format configuration of the value label.
    format_configuration: ?NumericFormatConfiguration = null,

    /// The relative position of the value label. Choose one of the following
    /// options:
    ///
    /// * `BEFORE_CUSTOM_LABEL`
    ///
    /// * `AFTER_CUSTOM_LABEL`
    relative_position: ?ReferenceLineValueLabelRelativePosition = null,

    pub const json_field_names = .{
        .format_configuration = "FormatConfiguration",
        .relative_position = "RelativePosition",
    };
};
