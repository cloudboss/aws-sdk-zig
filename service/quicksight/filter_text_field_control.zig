const TextFieldControlDisplayOptions = @import("text_field_control_display_options.zig").TextFieldControlDisplayOptions;

/// A control to display a text box that is used to enter a single entry.
pub const FilterTextFieldControl = struct {
    /// The display options of a control.
    display_options: ?TextFieldControlDisplayOptions,

    /// The ID of the `FilterTextFieldControl`.
    filter_control_id: []const u8,

    /// The source filter ID of the `FilterTextFieldControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterTextFieldControl`.
    title: []const u8,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
    };
};
