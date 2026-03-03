const SliderControlDisplayOptions = @import("slider_control_display_options.zig").SliderControlDisplayOptions;
const SheetControlSliderType = @import("sheet_control_slider_type.zig").SheetControlSliderType;

/// The default options that correspond to the `Slider` filter control type.
pub const DefaultSliderControlOptions = struct {
    /// The display options of a control.
    display_options: ?SliderControlDisplayOptions = null,

    /// The larger value that is displayed at the right of the slider.
    maximum_value: f64 = 0,

    /// The smaller value that is displayed at the left of the slider.
    minimum_value: f64 = 0,

    /// The number of increments that the slider bar is divided into.
    step_size: f64 = 0,

    /// The type of the `DefaultSliderControlOptions`. Choose one of the following
    /// options:
    ///
    /// * `SINGLE_POINT`: Filter against(equals) a single data point.
    ///
    /// * `RANGE`: Filter data that is in a specified range.
    @"type": ?SheetControlSliderType = null,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .maximum_value = "MaximumValue",
        .minimum_value = "MinimumValue",
        .step_size = "StepSize",
        .@"type" = "Type",
    };
};
