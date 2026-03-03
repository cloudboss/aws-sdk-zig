/// Details about an invitation.
pub const Invitation = struct {
    /// The account ID of the Security Hub administrator account that the invitation
    /// was sent from.
    account_id: ?[]const u8 = null,

    /// The ID of the invitation sent to the member account.
    invitation_id: ?[]const u8 = null,

    /// The timestamp of when the invitation was sent.
    invited_at: ?i64 = null,

    /// The current status of the association between the member and administrator
    /// accounts.
    member_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .invitation_id = "InvitationId",
        .invited_at = "InvitedAt",
        .member_status = "MemberStatus",
    };
};
