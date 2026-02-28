const SliderControlDisplayOptions = @import("slider_control_display_options.zig").SliderControlDisplayOptions;
const SheetControlSliderType = @import("sheet_control_slider_type.zig").SheetControlSliderType;

/// A control to display a horizontal toggle bar. This is used to change a value
/// by sliding the toggle.
pub const FilterSliderControl = struct {
    /// The display options of a control.
    display_options: ?SliderControlDisplayOptions,

    /// The ID of the `FilterSliderControl`.
    filter_control_id: []const u8,

    /// The larger value that is displayed at the right of the slider.
    maximum_value: f64 = 0,

    /// The smaller value that is displayed at the left of the slider.
    minimum_value: f64 = 0,

    /// The source filter ID of the `FilterSliderControl`.
    source_filter_id: []const u8,

    /// The number of increments that the slider bar is divided into.
    step_size: f64 = 0,

    /// The title of the `FilterSliderControl`.
    title: []const u8,

    /// The type of the `FilterSliderControl`. Choose one of the following options:
    ///
    /// * `SINGLE_POINT`: Filter against(equals) a single data point.
    ///
    /// * `RANGE`: Filter data that is in a specified range.
    @"type": ?SheetControlSliderType,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .maximum_value = "MaximumValue",
        .minimum_value = "MinimumValue",
        .source_filter_id = "SourceFilterId",
        .step_size = "StepSize",
        .title = "Title",
        .@"type" = "Type",
    };
};
