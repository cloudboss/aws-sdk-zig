const MessageType = @import("message_type.zig").MessageType;

/// Specifies the content and settings for an SMS message that's sent to
/// recipients of a campaign.
pub const CampaignSmsMessage = struct {
    /// The body of the SMS message.
    body: ?[]const u8 = null,

    /// The entity ID or Principal Entity (PE) id received from the regulatory body
    /// for sending SMS in your country.
    entity_id: ?[]const u8 = null,

    /// The SMS message type. Valid values are TRANSACTIONAL (for messages that are
    /// critical or time-sensitive, such as a one-time passwords) and PROMOTIONAL
    /// (for messsages that aren't critical or time-sensitive, such as marketing
    /// messages).
    message_type: ?MessageType = null,

    /// The long code to send the SMS message from. This value should be one of the
    /// dedicated long codes that's assigned to your AWS account. Although it isn't
    /// required, we recommend that you specify the long code using an E.164 format
    /// to ensure prompt and accurate delivery of the message. For example,
    /// +12065550100.
    origination_number: ?[]const u8 = null,

    /// The sender ID to display on recipients' devices when they receive the SMS
    /// message.
    sender_id: ?[]const u8 = null,

    /// The template ID received from the regulatory body for sending SMS in your
    /// country.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .entity_id = "EntityId",
        .message_type = "MessageType",
        .origination_number = "OriginationNumber",
        .sender_id = "SenderId",
        .template_id = "TemplateId",
    };
};
