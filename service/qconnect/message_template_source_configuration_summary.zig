const WhatsAppMessageTemplateSourceConfigurationSummary = @import("whats_app_message_template_source_configuration_summary.zig").WhatsAppMessageTemplateSourceConfigurationSummary;

/// The container of message template source configuration summary.
pub const MessageTemplateSourceConfigurationSummary = union(enum) {
    /// The sourceConfiguration summary of the message template that applies to the
    /// WHATSAPP channel subtype.
    whats_app: ?WhatsAppMessageTemplateSourceConfigurationSummary,

    pub const json_field_names = .{
        .whats_app = "whatsApp",
    };
};
