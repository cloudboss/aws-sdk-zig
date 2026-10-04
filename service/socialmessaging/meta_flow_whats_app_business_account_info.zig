/// Contains WhatsApp Business Account metadata associated with a Flow, as
/// returned by Meta.
pub const MetaFlowWhatsAppBusinessAccountInfo = struct {
    /// The currency code for the WhatsApp Business Account (for example, USD).
    currency: ?[]const u8 = null,

    /// The WhatsApp Business Account ID from Meta.
    id: []const u8,

    /// The message template namespace for the WhatsApp Business Account.
    message_template_namespace: ?[]const u8 = null,

    /// The name of the WhatsApp Business Account.
    name: []const u8,

    /// The timezone ID for the WhatsApp Business Account.
    timezone_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency = "currency",
        .id = "id",
        .message_template_namespace = "messageTemplateNamespace",
        .name = "name",
        .timezone_id = "timezoneId",
    };
};
