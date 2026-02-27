/// Summary of a profile.
pub const ProfileSummary = struct {
    created_at: ?i64,

    owner: ?[]const u8,

    /// The profile ARN.
    profile_arn: ?[]const u8,

    /// The profile description.
    profile_description: ?[]const u8,

    /// The profile name.
    profile_name: ?[]const u8,

    /// The profile version.
    profile_version: ?[]const u8,

    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .owner = "Owner",
        .profile_arn = "ProfileArn",
        .profile_description = "ProfileDescription",
        .profile_name = "ProfileName",
        .profile_version = "ProfileVersion",
        .updated_at = "UpdatedAt",
    };
};
