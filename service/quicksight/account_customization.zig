/// The Quick Sight customizations associated with your Amazon Web Services
/// account or a Quick Sight namespace in a specific Amazon Web Services Region.
pub const AccountCustomization = struct {
    /// The default email customization template.
    default_email_customization_template: ?[]const u8 = null,

    /// The default theme for this Quick Sight subscription.
    default_theme: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_email_customization_template = "DefaultEmailCustomizationTemplate",
        .default_theme = "DefaultTheme",
    };
};
