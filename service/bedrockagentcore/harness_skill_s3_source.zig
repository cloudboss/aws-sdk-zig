/// An S3 source for a skill.
pub const HarnessSkillS3Source = struct {
    /// The S3 URI pointing to the skill directory (e.g.,
    /// s3://bucket/skills/my-skill/).
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
