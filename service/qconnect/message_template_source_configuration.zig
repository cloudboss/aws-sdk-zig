const WhatsAppMessageTemplateSourceConfiguration = @import("whats_app_message_template_source_configuration.zig").WhatsAppMessageTemplateSourceConfiguration;

/// The container of message template source configuration.
pub const MessageTemplateSourceConfiguration = union(enum) {
    /// The sourceConfiguration of the message template that applies to the WHATSAPP
    /// channel subtype.
    whats_app: ?WhatsAppMessageTemplateSourceConfiguration,

    pub const json_field_names = .{
        .whats_app = "whatsApp",
    };
};
