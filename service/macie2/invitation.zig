const RelationshipStatus = @import("relationship_status.zig").RelationshipStatus;

/// Provides information about an Amazon Macie membership invitation.
pub const Invitation = struct {
    /// The Amazon Web Services account ID for the account that sent the invitation.
    account_id: ?[]const u8 = null,

    /// The unique identifier for the invitation.
    invitation_id: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the invitation
    /// was sent.
    invited_at: ?i64 = null,

    /// The status of the relationship between the account that sent the invitation
    /// and the account that received the invitation.
    relationship_status: ?RelationshipStatus = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .invitation_id = "invitationId",
        .invited_at = "invitedAt",
        .relationship_status = "relationshipStatus",
    };
};
