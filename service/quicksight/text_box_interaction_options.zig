const TextBoxMenuOption = @import("text_box_menu_option.zig").TextBoxMenuOption;

/// The general textbox interactions setup for textbox publish options.
pub const TextBoxInteractionOptions = struct {
    /// The menu options for the textbox.
    text_box_menu_option: ?TextBoxMenuOption = null,

    pub const json_field_names = .{
        .text_box_menu_option = "TextBoxMenuOption",
    };
};
