const GitLabTokenType = @import("git_lab_token_type.zig").GitLabTokenType;

/// The configuration for creating a GitLab integration.
pub const GitLabIntegrationInput = struct {
    /// The GitLab access token used to authenticate. This can be a personal access
    /// token or a group access token.
    access_token: []const u8,

    /// The identifier of the GitLab group. Required when tokenType is group and
    /// ignored for personal tokens.
    group_id: ?[]const u8 = null,

    /// The HTTPS URL of a self-managed GitLab instance. Omit this value for GitLab
    /// SaaS (gitlab.com).
    target_url: ?[]const u8 = null,

    /// The type of GitLab access token provided in accessToken.
    token_type: GitLabTokenType,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .group_id = "groupId",
        .target_url = "targetUrl",
        .token_type = "tokenType",
    };
};
