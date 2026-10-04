const HarnessSkillAwsSkillsSource = @import("harness_skill_aws_skills_source.zig").HarnessSkillAwsSkillsSource;
const HarnessSkillGitSource = @import("harness_skill_git_source.zig").HarnessSkillGitSource;
const HarnessSkillS3Source = @import("harness_skill_s3_source.zig").HarnessSkillS3Source;

/// A skill available to the agent.
pub const HarnessSkill = union(enum) {
    /// AWS Skills baked into the harness's underlying Runtime.
    aws_skills: ?HarnessSkillAwsSkillsSource,
    /// A git repository containing the skill.
    git: ?HarnessSkillGitSource,
    /// The filesystem path to the skill definition.
    path: ?[]const u8,
    /// An S3 source containing the skill.
    s_3: ?HarnessSkillS3Source,

    pub const json_field_names = .{
        .aws_skills = "awsSkills",
        .git = "git",
        .path = "path",
        .s_3 = "s3",
    };
};
