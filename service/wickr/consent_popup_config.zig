/// Consent popup configuration displayed to users on login.
pub const ConsentPopupConfig = struct {
    /// Label for the close button on the consent popup. Maximum 20 characters.
    /// Defaults to "Acknowledge" if not provided.
    close_button_label: ?[]const u8 = null,

    /// Body content of the consent popup in Markdown format. Maximum 5000
    /// characters.
    content: ?[]const u8 = null,

    /// Whether the consent popup is enabled. When set to true, the popup is
    /// displayed to users on login.
    enabled: bool,

    /// Header text displayed at the top of the consent popup. Maximum 100
    /// characters.
    header: ?[]const u8 = null,

    pub const json_field_names = .{
        .close_button_label = "closeButtonLabel",
        .content = "content",
        .enabled = "enabled",
        .header = "header",
    };
};
