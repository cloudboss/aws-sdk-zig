const DateTimePickerControlDisplayOptions = @import("date_time_picker_control_display_options.zig").DateTimePickerControlDisplayOptions;

/// A control from a date parameter that specifies date and time.
pub const ParameterDateTimePickerControl = struct {
    /// The display options of a control.
    display_options: ?DateTimePickerControlDisplayOptions = null,

    /// The ID of the `ParameterDateTimePickerControl`.
    parameter_control_id: []const u8,

    /// The name of the `ParameterDateTimePickerControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterDateTimePickerControl`.
    title: []const u8,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
    };
};
