/// Contains information about the administrator account and invitation.
pub const Master = struct {
    /// The ID of the account used as the administrator account.
    account_id: ?[]const u8 = null,

    /// The value used to validate the administrator account to the member account.
    invitation_id: ?[]const u8 = null,

    /// The timestamp when the invitation was sent.
    invited_at: ?[]const u8 = null,

    /// The status of the relationship between the administrator and member
    /// accounts.
    relationship_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .invitation_id = "InvitationId",
        .invited_at = "InvitedAt",
        .relationship_status = "RelationshipStatus",
    };
};
