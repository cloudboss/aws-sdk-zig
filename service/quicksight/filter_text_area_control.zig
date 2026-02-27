const TextAreaControlDisplayOptions = @import("text_area_control_display_options.zig").TextAreaControlDisplayOptions;

/// A control to display a text box that is used to enter multiple entries.
pub const FilterTextAreaControl = struct {
    /// The delimiter that is used to separate the lines in text.
    delimiter: ?[]const u8,

    /// The display options of a control.
    display_options: ?TextAreaControlDisplayOptions,

    /// The ID of the `FilterTextAreaControl`.
    filter_control_id: []const u8,

    /// The source filter ID of the `FilterTextAreaControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterTextAreaControl`.
    title: []const u8,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
    };
};
