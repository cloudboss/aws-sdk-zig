const TopicUserExperienceVersion = @import("topic_user_experience_version.zig").TopicUserExperienceVersion;

/// A topic summary.
pub const TopicSummary = struct {
    /// The Amazon Resource Name (ARN) of the topic.
    arn: ?[]const u8,

    /// The name of the topic.
    name: ?[]const u8,

    /// The ID for the topic. This ID is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    topic_id: ?[]const u8,

    /// The user experience version of the topic.
    user_experience_version: ?TopicUserExperienceVersion,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .topic_id = "TopicId",
        .user_experience_version = "UserExperienceVersion",
    };
};
