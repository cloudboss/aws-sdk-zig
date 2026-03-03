const RecipientDetail = @import("recipient_detail.zig").RecipientDetail;

/// Contains the information of one or more recipients who receive the emails.
///
/// You must [add the users that receive emails to your AWS SSO
/// store](https://docs.aws.amazon.com/singlesignon/latest/userguide/addusers.html).
pub const EmailRecipients = struct {
    /// Specifies one or more recipients who receive the email.
    to: ?[]const RecipientDetail = null,

    pub const json_field_names = .{
        .to = "to",
    };
};
