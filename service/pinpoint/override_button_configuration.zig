const ButtonAction = @import("button_action.zig").ButtonAction;

/// Override button configuration.
pub const OverrideButtonConfiguration = struct {
    /// Action triggered by the button.
    button_action: ButtonAction,

    /// Button destination.
    link: ?[]const u8,

    pub const json_field_names = .{
        .button_action = "ButtonAction",
        .link = "Link",
    };
};
