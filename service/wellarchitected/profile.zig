const aws = @import("aws");

const ProfileQuestion = @import("profile_question.zig").ProfileQuestion;

/// A profile.
pub const Profile = struct {
    created_at: ?i64 = null,

    owner: ?[]const u8 = null,

    /// The profile ARN.
    profile_arn: ?[]const u8 = null,

    /// The profile description.
    profile_description: ?[]const u8 = null,

    /// The profile name.
    profile_name: ?[]const u8 = null,

    /// Profile questions.
    profile_questions: ?[]const ProfileQuestion = null,

    /// The profile version.
    profile_version: ?[]const u8 = null,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8 = null,

    /// The tags assigned to the profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .owner = "Owner",
        .profile_arn = "ProfileArn",
        .profile_description = "ProfileDescription",
        .profile_name = "ProfileName",
        .profile_questions = "ProfileQuestions",
        .profile_version = "ProfileVersion",
        .share_invitation_id = "ShareInvitationId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};
