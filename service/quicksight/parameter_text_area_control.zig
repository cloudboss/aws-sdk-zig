const TextAreaControlDisplayOptions = @import("text_area_control_display_options.zig").TextAreaControlDisplayOptions;

/// A control to display a text box that is used to enter multiple entries.
pub const ParameterTextAreaControl = struct {
    /// The delimiter that is used to separate the lines in text.
    delimiter: ?[]const u8 = null,

    /// The display options of a control.
    display_options: ?TextAreaControlDisplayOptions = null,

    /// The ID of the `ParameterTextAreaControl`.
    parameter_control_id: []const u8,

    /// The source parameter name of the `ParameterTextAreaControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterTextAreaControl`.
    title: []const u8,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
    };
};
