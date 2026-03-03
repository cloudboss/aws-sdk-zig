const aws = @import("aws");

const MessageType = @import("message_type.zig").MessageType;

/// Specifies the default settings for a one-time SMS message that's sent
/// directly to an endpoint.
pub const SMSMessage = struct {
    /// The body of the SMS message.
    body: ?[]const u8 = null,

    /// The entity ID or Principal Entity (PE) id received from the regulatory body
    /// for sending SMS in your country.
    entity_id: ?[]const u8 = null,

    /// The SMS program name that you provided to AWS Support when you requested
    /// your dedicated number.
    keyword: ?[]const u8 = null,

    /// This field is reserved for future use.
    media_url: ?[]const u8 = null,

    /// The SMS message type. Valid values are TRANSACTIONAL (for messages that are
    /// critical or time-sensitive, such as a one-time passwords) and PROMOTIONAL
    /// (for messsages that aren't critical or time-sensitive, such as marketing
    /// messages).
    message_type: ?MessageType = null,

    /// The number to send the SMS message from. This value should be one of the
    /// dedicated long or short codes that's assigned to your AWS account. If you
    /// don't specify a long or short code, Amazon Pinpoint assigns a random long
    /// code to the SMS message and sends the message from that code.
    origination_number: ?[]const u8 = null,

    /// The sender ID to display as the sender of the message on a recipient's
    /// device. Support for sender IDs varies by country or region.
    sender_id: ?[]const u8 = null,

    /// The message variables to use in the SMS message. You can override the
    /// default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The template ID received from the regulatory body for sending SMS in your
    /// country.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .entity_id = "EntityId",
        .keyword = "Keyword",
        .media_url = "MediaUrl",
        .message_type = "MessageType",
        .origination_number = "OriginationNumber",
        .sender_id = "SenderId",
        .substitutions = "Substitutions",
        .template_id = "TemplateId",
    };
};
