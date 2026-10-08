const GitLabTokenType = @import("git_lab_token_type.zig").GitLabTokenType;

/// Service details for GitLab integration.
pub const GitLabDetails = struct {
    /// Optional GitLab group ID for group-level access tokens
    group_id: ?[]const u8 = null,

    /// GitLab instance URL (e.g., https://gitlab.com or self-hosted instance).
    target_url: []const u8,

    /// Type of GitLab access token
    token_type: GitLabTokenType,

    /// GitLab access token value
    token_value: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .target_url = "targetUrl",
        .token_type = "tokenType",
        .token_value = "tokenValue",
    };
};
