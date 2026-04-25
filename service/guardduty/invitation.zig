/// Contains information about the invitation to become a member account.
pub const Invitation = struct {
    /// The ID of the account that the invitation was sent from.
    account_id: ?[]const u8 = null,

    /// The ID of the invitation. This value is used to validate the inviter account
    /// to the member account.
    invitation_id: ?[]const u8 = null,

    /// The timestamp when the invitation was sent.
    invited_at: ?[]const u8 = null,

    /// The status of the relationship between the inviter and invitee accounts.
    relationship_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .invitation_id = "InvitationId",
        .invited_at = "InvitedAt",
        .relationship_status = "RelationshipStatus",
    };
};
