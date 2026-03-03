/// The details about a member account.
pub const Member = struct {
    /// The Amazon Web Services account ID of the member account.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the Security Hub administrator account
    /// associated with this member account.
    administrator_id: ?[]const u8 = null,

    /// The email address of the member account.
    email: ?[]const u8 = null,

    /// A timestamp for the date and time when the invitation was sent to the member
    /// account.
    invited_at: ?i64 = null,

    /// This is replaced by `AdministratorID`.
    ///
    /// The Amazon Web Services account ID of the Security Hub administrator account
    /// associated with this member account.
    master_id: ?[]const u8 = null,

    /// The status of the relationship between the member account and its
    /// administrator account.
    ///
    /// The status can have one of the following values:
    ///
    /// * `Created` - Indicates that the administrator account added the member
    ///   account,
    /// but has not yet invited the member account.
    ///
    /// * `Invited` - Indicates that the administrator account invited the member
    /// account. The member account has not yet responded to the invitation.
    ///
    /// * `Enabled` - Indicates that the member account is currently active. For
    /// manually invited member accounts, indicates that the member account accepted
    /// the
    /// invitation.
    ///
    /// * `Removed` - Indicates that the administrator account disassociated the
    ///   member
    /// account.
    ///
    /// * `Resigned` - Indicates that the member account disassociated themselves
    /// from the administrator account.
    ///
    /// * `Deleted` - Indicates that the administrator account deleted the member
    /// account.
    ///
    /// * `AccountSuspended` - Indicates that an organization account was suspended
    ///   from Amazon Web Services at the same time that the administrator account
    ///   tried to enable the organization account as a member account.
    member_status: ?[]const u8 = null,

    /// The timestamp for the date and time when the member account was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .administrator_id = "AdministratorId",
        .email = "Email",
        .invited_at = "InvitedAt",
        .master_id = "MasterId",
        .member_status = "MemberStatus",
        .updated_at = "UpdatedAt",
    };
};
