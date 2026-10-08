const WebhookType = @import("webhook_type.zig").WebhookType;

/// Represents a complete Webhook with all its properties, and unique
/// identifier.
pub const Webhook = struct {
    /// The unique identifier of the Webhook
    webhook_id: []const u8,

    /// Webhook authentication type.
    webhook_type: ?WebhookType = null,

    /// Webhook endpoint URL.
    webhook_url: []const u8,

    pub const json_field_names = .{
        .webhook_id = "webhookId",
        .webhook_type = "webhookType",
        .webhook_url = "webhookUrl",
    };
};
