/// Passed to show that Amazon Web Services Skills should be included.
pub const HarnessSkillAwsSkillsSource = struct {
    /// Optionally filter allowed skills with glob syntax, e.g., ['core-skills/*'].
    paths: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .paths = "paths",
    };
};
