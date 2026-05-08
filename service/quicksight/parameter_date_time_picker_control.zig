const ControlTitleFormatText = @import("control_title_format_text.zig").ControlTitleFormatText;
const DateTimePickerControlDisplayOptions = @import("date_time_picker_control_display_options.zig").DateTimePickerControlDisplayOptions;

/// A control from a date parameter that specifies date and time.
pub const ParameterDateTimePickerControl = struct {
    /// The title text format configuration for the control.
    control_title_format_text: ?ControlTitleFormatText = null,

    /// The display options of a control.
    display_options: ?DateTimePickerControlDisplayOptions = null,

    /// The ID of the `ParameterDateTimePickerControl`.
    parameter_control_id: []const u8,

    /// The name of the `ParameterDateTimePickerControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterDateTimePickerControl`.
    title: []const u8 = "",

    pub const json_field_names = .{
        .control_title_format_text = "ControlTitleFormatText",
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
    };
};
