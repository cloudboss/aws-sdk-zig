const WhatsAppSourceConfigurationStatus = @import("whats_app_source_configuration_status.zig").WhatsAppSourceConfigurationStatus;

/// Configuration information about the external data source.
pub const WhatsAppMessageTemplateSourceConfigurationSummary = struct {
    /// The ID of the End User Messaging WhatsApp Business Account to associate with
    /// this template.
    business_account_id: []const u8,

    /// The list of component mapping from WhatsApp template parameters to Message
    /// Template attributes.
    components: ?[]const []const u8 = null,

    /// The language of the WhatsApp template.
    language: ?[]const u8 = null,

    /// The name of the WhatsApp template.
    name: ?[]const u8 = null,

    /// The status of the message template.
    status: ?WhatsAppSourceConfigurationStatus = null,

    /// The status reason of the message template.
    status_reason: ?[]const u8 = null,

    /// The ID of WhatsApp template.
    template_id: []const u8,

    pub const json_field_names = .{
        .business_account_id = "businessAccountId",
        .components = "components",
        .language = "language",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
        .template_id = "templateId",
    };
};
