const EmailStatus = @import("email_status.zig").EmailStatus;
const InviteStatus = @import("invite_status.zig").InviteStatus;

/// Invitation object returned after emailing users to invite them to join the
/// Amazon Chime
/// `Team` account.
pub const Invite = struct {
    /// The email address to which the invite is sent.
    email_address: ?[]const u8,

    /// The status of the invite email.
    email_status: ?EmailStatus,

    /// The invite ID.
    invite_id: ?[]const u8,

    /// The status of the invite.
    status: ?InviteStatus,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
        .email_status = "EmailStatus",
        .invite_id = "InviteId",
        .status = "Status",
    };
};
