const GitLabTokenType = @import("git_lab_token_type.zig").GitLabTokenType;

/// Details specific to a registered GitLab instance.
pub const RegisteredGitLabServiceDetails = struct {
    /// Optional GitLab group ID for group-level access tokens
    group_id: ?[]const u8 = null,

    /// The GitLab instance URL.
    target_url: []const u8,

    /// Type of GitLab access token
    token_type: GitLabTokenType,

    pub const json_field_names = .{
        .group_id = "groupId",
        .target_url = "targetUrl",
        .token_type = "tokenType",
    };
};
