/// Contains information about the member account.
pub const Member = struct {
    /// The ID of the member account.
    account_id: []const u8,

    /// The administrator account ID.
    administrator_id: ?[]const u8,

    /// The detector ID of the member account.
    detector_id: ?[]const u8,

    /// The email address of the member account.
    email: []const u8,

    /// The timestamp when the invitation was sent.
    invited_at: ?[]const u8,

    /// The administrator account ID.
    master_id: []const u8,

    /// The status of the relationship between the member and the administrator.
    relationship_status: []const u8,

    /// The last-updated timestamp of the member.
    updated_at: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .administrator_id = "AdministratorId",
        .detector_id = "DetectorId",
        .email = "Email",
        .invited_at = "InvitedAt",
        .master_id = "MasterId",
        .relationship_status = "RelationshipStatus",
        .updated_at = "UpdatedAt",
    };
};
