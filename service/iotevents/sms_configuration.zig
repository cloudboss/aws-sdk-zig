const RecipientDetail = @import("recipient_detail.zig").RecipientDetail;

/// Contains the configuration information of SMS notifications.
pub const SMSConfiguration = struct {
    /// The message that you want to send. The message can be up to 200 characters.
    additional_message: ?[]const u8 = null,

    /// Specifies one or more recipients who receive the message.
    ///
    /// You must [add the users that receive SMS messages to your AWS SSO
    /// store](https://docs.aws.amazon.com/singlesignon/latest/userguide/addusers.html).
    recipients: []const RecipientDetail,

    /// The sender ID.
    sender_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_message = "additionalMessage",
        .recipients = "recipients",
        .sender_id = "senderId",
    };
};
