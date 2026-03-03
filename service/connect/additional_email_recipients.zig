const EmailRecipient = @import("email_recipient.zig").EmailRecipient;

/// List of additional email addresses for an email contact.
pub const AdditionalEmailRecipients = struct {
    /// List of additional CC email recipients for an email contact.
    cc_list: ?[]const EmailRecipient = null,

    /// List of additional TO email recipients for an email contact.
    to_list: ?[]const EmailRecipient = null,

    pub const json_field_names = .{
        .cc_list = "CcList",
        .to_list = "ToList",
    };
};
