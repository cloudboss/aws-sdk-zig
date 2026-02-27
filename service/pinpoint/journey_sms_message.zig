const MessageType = @import("message_type.zig").MessageType;

/// Specifies the sender ID and message type for an SMS message that's sent to
/// participants in a journey.
pub const JourneySMSMessage = struct {
    /// The entity ID or Principal Entity (PE) id received from the regulatory body
    /// for sending SMS in your country.
    entity_id: ?[]const u8,

    /// The SMS message type. Valid values are TRANSACTIONAL (for messages that are
    /// critical or time-sensitive, such as a one-time passwords) and PROMOTIONAL
    /// (for messsages that aren't critical or time-sensitive, such as marketing
    /// messages).
    message_type: ?MessageType,

    /// The long code to send the SMS message from. This value should be one of the
    /// dedicated long codes that's assigned to your AWS account. Although it isn't
    /// required, we recommend that you specify the long code using an E.164 format
    /// to ensure prompt and accurate delivery of the message. For example,
    /// +12065550100.
    origination_number: ?[]const u8,

    /// The sender ID to display as the sender of the message on a recipient's
    /// device. Support for sender IDs varies by country or region. For more
    /// information, see [Supported Countries and
    /// Regions](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-sms-countries.html) in the Amazon Pinpoint User Guide.
    sender_id: ?[]const u8,

    /// The template ID received from the regulatory body for sending SMS in your
    /// country.
    template_id: ?[]const u8,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .message_type = "MessageType",
        .origination_number = "OriginationNumber",
        .sender_id = "SenderId",
        .template_id = "TemplateId",
    };
};
