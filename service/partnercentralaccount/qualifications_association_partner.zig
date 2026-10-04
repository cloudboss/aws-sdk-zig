/// Identifies a partner in a qualifications association group. Contains the
/// partner's profile identifier and AWS account identifier. In requests,
/// provide at least one of `ProfileId` or `AccountId`. In responses, both
/// fields are populated.
pub const QualificationsAssociationPartner = struct {
    /// The 12-digit AWS account ID linked to the partner profile. Required in
    /// requests if `ProfileId` is not provided.
    account_id: ?[]const u8 = null,

    /// The unique identifier for the partner profile, in the format `pprofile-*`.
    /// Required in requests if `AccountId` is not provided.
    profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .profile_id = "ProfileId",
    };
};
