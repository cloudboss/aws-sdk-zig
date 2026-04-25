/// The details of the IAM user profile.
pub const IamUserProfileDetails = struct {
    /// The ARN of the IAM user.
    arn: ?[]const u8 = null,

    /// The identifier of the group profile associated with the IAM user profile.
    /// This links the user to a specific group profile within the Amazon DataZone
    /// domain.
    group_profile_id: ?[]const u8 = null,

    /// The principal ID as part of the IAM user profile details.
    principal_id: ?[]const u8 = null,

    /// The session name for IAM role sessions.
    session_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .group_profile_id = "groupProfileId",
        .principal_id = "principalId",
        .session_name = "sessionName",
    };
};
