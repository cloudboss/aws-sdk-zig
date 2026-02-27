const aws = @import("aws");

const ProfileQuestion = @import("profile_question.zig").ProfileQuestion;

/// A profile.
pub const Profile = struct {
    created_at: ?i64,

    owner: ?[]const u8,

    /// The profile ARN.
    profile_arn: ?[]const u8,

    /// The profile description.
    profile_description: ?[]const u8,

    /// The profile name.
    profile_name: ?[]const u8,

    /// Profile questions.
    profile_questions: ?[]const ProfileQuestion,

    /// The profile version.
    profile_version: ?[]const u8,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8,

    /// The tags assigned to the profile.
    tags: ?[]const aws.map.StringMapEntry,

    updated_at: ?i64,

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
