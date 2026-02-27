/// Configuration information about the external data source.
pub const WhatsAppMessageTemplateSourceConfiguration = struct {
    /// The ID of the End User Messaging WhatsApp Business Account to associate with
    /// this template.
    business_account_id: []const u8,

    /// The list of component mapping from WhatsApp template parameters to Message
    /// Template attributes.
    components: ?[]const []const u8,

    /// The WhatsApp template ID.
    template_id: []const u8,

    pub const json_field_names = .{
        .business_account_id = "businessAccountId",
        .components = "components",
        .template_id = "templateId",
    };
};
