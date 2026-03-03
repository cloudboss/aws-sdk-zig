const TextAreaControlDisplayOptions = @import("text_area_control_display_options.zig").TextAreaControlDisplayOptions;

/// The default options that correspond to the `TextArea` filter control type.
pub const DefaultTextAreaControlOptions = struct {
    /// The delimiter that is used to separate the lines in text.
    delimiter: ?[]const u8 = null,

    /// The display options of a control.
    display_options: ?TextAreaControlDisplayOptions = null,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
        .display_options = "DisplayOptions",
    };
};
