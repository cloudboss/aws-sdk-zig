const ButtonAction = @import("button_action.zig").ButtonAction;

/// Default button configuration.
pub const DefaultButtonConfiguration = struct {
    /// The background color of the button.
    background_color: ?[]const u8 = null,

    /// The border radius of the button.
    border_radius: ?i32 = null,

    /// Action triggered by the button.
    button_action: ButtonAction,

    /// Button destination.
    link: ?[]const u8 = null,

    /// Button text.
    text: []const u8,

    /// The text color of the button.
    text_color: ?[]const u8 = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .border_radius = "BorderRadius",
        .button_action = "ButtonAction",
        .link = "Link",
        .text = "Text",
        .text_color = "TextColor",
    };
};
