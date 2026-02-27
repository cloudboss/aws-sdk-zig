/// The details of the IAM user profile.
pub const IamUserProfileDetails = struct {
    /// The ARN of the IAM user.
    arn: ?[]const u8,

    /// The principal ID as part of the IAM user profile details.
    principal_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .principal_id = "principalId",
    };
};
