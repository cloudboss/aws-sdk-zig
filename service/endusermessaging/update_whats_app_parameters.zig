/// The updated delivery parameters for the WhatsApp channel. Absent members
/// preserve the current value, and the empty sentinel on a member clears it.
pub const UpdateWhatsAppParameters = struct {
    /// The updated BCP 47 language code. An empty string clears the previously
    /// stored value.
    language_code: ?[]const u8 = null,

    /// The updated name of the Meta-approved WhatsApp authentication template. An
    /// empty string clears the previously stored value.
    whats_app_template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "languageCode",
        .whats_app_template_name = "whatsAppTemplateName",
    };
};
