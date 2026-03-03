const FormButton = @import("form_button.zig").FormButton;
const FormButtonsPosition = @import("form_buttons_position.zig").FormButtonsPosition;

/// Describes the call to action button configuration for the form.
pub const FormCTA = struct {
    /// Displays a cancel button.
    cancel: ?FormButton = null,

    /// Displays a clear button.
    clear: ?FormButton = null,

    /// The position of the button.
    position: ?FormButtonsPosition = null,

    /// Displays a submit button.
    submit: ?FormButton = null,

    pub const json_field_names = .{
        .cancel = "cancel",
        .clear = "clear",
        .position = "position",
        .submit = "submit",
    };
};
