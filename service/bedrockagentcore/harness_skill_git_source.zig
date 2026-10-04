const HarnessSkillGitAuth = @import("harness_skill_git_auth.zig").HarnessSkillGitAuth;

/// A git repository source for a skill.
pub const HarnessSkillGitSource = struct {
    /// Authentication configuration for private repositories.
    auth: ?HarnessSkillGitAuth = null,

    /// Subdirectory within the repository containing the skill.
    path: ?[]const u8 = null,

    /// The HTTPS URL of the git repository.
    url: []const u8,

    pub const json_field_names = .{
        .auth = "auth",
        .path = "path",
        .url = "url",
    };
};
