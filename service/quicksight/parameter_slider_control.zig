const SliderControlDisplayOptions = @import("slider_control_display_options.zig").SliderControlDisplayOptions;

/// A control to display a horizontal toggle bar. This is used to change a value
/// by sliding the toggle.
pub const ParameterSliderControl = struct {
    /// The display options of a control.
    display_options: ?SliderControlDisplayOptions,

    /// The larger value that is displayed at the right of the slider.
    maximum_value: f64 = 0,

    /// The smaller value that is displayed at the left of the slider.
    minimum_value: f64 = 0,

    /// The ID of the `ParameterSliderControl`.
    parameter_control_id: []const u8,

    /// The source parameter name of the `ParameterSliderControl`.
    source_parameter_name: []const u8,

    /// The number of increments that the slider bar is divided into.
    step_size: f64 = 0,

    /// The title of the `ParameterSliderControl`.
    title: []const u8,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .maximum_value = "MaximumValue",
        .minimum_value = "MinimumValue",
        .parameter_control_id = "ParameterControlId",
        .source_parameter_name = "SourceParameterName",
        .step_size = "StepSize",
        .title = "Title",
    };
};
