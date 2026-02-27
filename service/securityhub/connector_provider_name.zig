pub const ConnectorProviderName = enum {
    jira_cloud,
    servicenow,

    pub const json_field_names = .{
        .jira_cloud = "JIRA_CLOUD",
        .servicenow = "SERVICENOW",
    };
};
