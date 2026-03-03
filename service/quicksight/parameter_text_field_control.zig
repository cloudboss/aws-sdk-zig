const TextFieldControlDisplayOptions = @import("text_field_control_display_options.zig").TextFieldControlDisplayOptions;

/// A control to display a text box that is used to enter a single entry.
pub const ParameterTextFieldControl = struct {
    /// The display options of a control.
    display_options: ?TextFieldControlDisplayOptions = null,

    /// The ID of the `ParameterTextFieldControl`.
    parameter_control_id: []const u8,

    /// The source parameter name of the `ParameterTextFieldControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterTextFieldControl`.
    title: []const u8,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
    };
};
