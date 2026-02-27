const EmailContactStatus = @import("email_contact_status.zig").EmailContactStatus;

/// An email contact.
pub const EmailContact = struct {
    /// The email address this email contact points to. The activation email and any
    /// subscribed emails are sent here.
    address: []const u8,

    /// The Amazon Resource Name (ARN) of the email contact.
    arn: []const u8,

    /// The creation time of the resource.
    creation_time: i64,

    /// The name of the email contact.
    name: []const u8,

    /// The status of the email contact. Only activated email contacts receive
    /// emails.
    status: EmailContactStatus,

    /// The time the resource was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .address = "address",
        .arn = "arn",
        .creation_time = "creationTime",
        .name = "name",
        .status = "status",
        .update_time = "updateTime",
    };
};
