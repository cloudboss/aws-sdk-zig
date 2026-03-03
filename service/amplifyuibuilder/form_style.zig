const FormStyleConfig = @import("form_style_config.zig").FormStyleConfig;

/// Describes the configuration for the form's style.
pub const FormStyle = struct {
    /// The spacing for the horizontal gap.
    horizontal_gap: ?FormStyleConfig = null,

    /// The size of the outer padding for the form.
    outer_padding: ?FormStyleConfig = null,

    /// The spacing for the vertical gap.
    vertical_gap: ?FormStyleConfig = null,

    pub const json_field_names = .{
        .horizontal_gap = "horizontalGap",
        .outer_padding = "outerPadding",
        .vertical_gap = "verticalGap",
    };
};
