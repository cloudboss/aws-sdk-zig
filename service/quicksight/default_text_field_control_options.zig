const TextFieldControlDisplayOptions = @import("text_field_control_display_options.zig").TextFieldControlDisplayOptions;

/// The default options that correspond to the `TextField` filter control type.
pub const DefaultTextFieldControlOptions = struct {
    /// The display options of a control.
    display_options: ?TextFieldControlDisplayOptions,

    pub const json_field_names = .{
        .display_options = "DisplayOptions",
    };
};
