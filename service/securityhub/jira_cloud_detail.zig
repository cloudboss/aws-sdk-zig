const ConnectorAuthStatus = @import("connector_auth_status.zig").ConnectorAuthStatus;

/// Information about the configuration and status of a Jira Cloud integration.
pub const JiraCloudDetail = struct {
    /// The status of the authorization between Jira Cloud and the service.
    auth_status: ?ConnectorAuthStatus = null,

    /// The URL to provide to customers for OAuth auth code flow.
    auth_url: ?[]const u8 = null,

    /// The cloud id of the Jira Cloud.
    cloud_id: ?[]const u8 = null,

    /// The URL domain of your Jira Cloud instance.
    domain: ?[]const u8 = null,

    /// The projectKey of Jira Cloud.
    project_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_status = "AuthStatus",
        .auth_url = "AuthUrl",
        .cloud_id = "CloudId",
        .domain = "Domain",
        .project_key = "ProjectKey",
    };
};
