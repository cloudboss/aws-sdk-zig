/// The delivery parameters for the WhatsApp channel.
pub const WhatsAppParameters = struct {
    /// The BCP 47 language code used to render the template. This value is required
    /// for the WhatsApp channel.
    language_code: ?[]const u8 = null,

    /// The name of the Meta-approved WhatsApp authentication template.
    whats_app_template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "languageCode",
        .whats_app_template_name = "whatsAppTemplateName",
    };
};
