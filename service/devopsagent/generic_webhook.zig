const WebhookType = @import("webhook_type.zig").WebhookType;

/// Generic webhook configuration for services that support webhook
/// notifications.
pub const GenericWebhook = struct {
    /// API Key for API Key webhook authentication
    api_key: ?[]const u8 = null,

    /// The unique webhook identifier
    webhook_id: ?[]const u8 = null,

    /// The webhook secret for authentication
    webhook_secret: ?[]const u8 = null,

    /// The webhook authentication type
    webhook_type: ?WebhookType = null,

    /// The webhook URL endpoint
    webhook_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .webhook_id = "webhookId",
        .webhook_secret = "webhookSecret",
        .webhook_type = "webhookType",
        .webhook_url = "webhookUrl",
    };
};
