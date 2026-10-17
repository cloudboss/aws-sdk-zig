const Provider = @import("provider.zig").Provider;

/// A reference to an issue created for a finding in a third-party issue
/// tracker.
pub const LinkedIssue = struct {
    /// The integration identifier for the issue-tracker provider.
    integration_id: ?[]const u8 = null,

    /// The stable numeric issue identifier.
    issue_id: ?[]const u8 = null,

    /// The issue key.
    issue_key: ?[]const u8 = null,

    /// The issue URL.
    issue_url: ?[]const u8 = null,

    /// The key of the project the issue belongs to.
    project_key: ?[]const u8 = null,

    /// The issue-tracker provider.
    provider: ?Provider = null,

    /// The Atlassian Cloud site URL.
    site_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .integration_id = "integrationId",
        .issue_id = "issueId",
        .issue_key = "issueKey",
        .issue_url = "issueUrl",
        .project_key = "projectKey",
        .provider = "provider",
        .site_url = "siteUrl",
    };
};
