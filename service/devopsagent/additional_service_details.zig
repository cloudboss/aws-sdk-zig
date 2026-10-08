const RegisteredAzureDevOpsServiceDetails = @import("registered_azure_dev_ops_service_details.zig").RegisteredAzureDevOpsServiceDetails;
const RegisteredAzureIdentityDetails = @import("registered_azure_identity_details.zig").RegisteredAzureIdentityDetails;
const RegisteredGithubServiceDetails = @import("registered_github_service_details.zig").RegisteredGithubServiceDetails;
const RegisteredGitLabServiceDetails = @import("registered_git_lab_service_details.zig").RegisteredGitLabServiceDetails;
const RegisteredMCPServerDetails = @import("registered_mcp_server_details.zig").RegisteredMCPServerDetails;
const RegisteredGrafanaServerDetails = @import("registered_grafana_server_details.zig").RegisteredGrafanaServerDetails;
const RegisteredNewRelicDetails = @import("registered_new_relic_details.zig").RegisteredNewRelicDetails;
const RegisteredMCPServerSigV4Details = @import("registered_mcp_server_sig_v4_details.zig").RegisteredMCPServerSigV4Details;
const RegisteredPagerDutyDetails = @import("registered_pager_duty_details.zig").RegisteredPagerDutyDetails;
const RegisteredRemoteAgentDetails = @import("registered_remote_agent_details.zig").RegisteredRemoteAgentDetails;
const RegisteredRemoteAgentSigV4Details = @import("registered_remote_agent_sig_v4_details.zig").RegisteredRemoteAgentSigV4Details;
const RegisteredServiceNowDetails = @import("registered_service_now_details.zig").RegisteredServiceNowDetails;
const RegisteredSlackServiceDetails = @import("registered_slack_service_details.zig").RegisteredSlackServiceDetails;

/// Union of service-specific details for different service types.
pub const AdditionalServiceDetails = union(enum) {
    /// Azure DevOps specific service details.
    azuredevops: ?RegisteredAzureDevOpsServiceDetails,
    /// Azure identity details for services using Azure authentication.
    azureidentity: ?RegisteredAzureIdentityDetails,
    /// GitHub-specific service details.
    github: ?RegisteredGithubServiceDetails,
    /// GitLab-specific service details.
    gitlab: ?RegisteredGitLabServiceDetails,
    /// MCP server-specific service details.
    mcpserver: ?RegisteredMCPServerDetails,
    /// Datadog MCP server-specific service details.
    mcpserverdatadog: ?RegisteredMCPServerDetails,
    /// Grafana MCP server-specific service details.
    mcpservergrafana: ?RegisteredGrafanaServerDetails,
    /// New Relic MCP server-specific service details.
    mcpservernewrelic: ?RegisteredNewRelicDetails,
    /// SigV4-authenticated MCP server-specific service details.
    mcpserversigv_4: ?RegisteredMCPServerSigV4Details,
    /// Splunk MCP server-specific service details.
    mcpserversplunk: ?RegisteredMCPServerDetails,
    /// Pagerduty service details.
    pagerduty: ?RegisteredPagerDutyDetails,
    /// Remote A2A agent-specific service details (token-based auth).
    remoteagent: ?RegisteredRemoteAgentDetails,
    /// Remote A2A agent-specific service details (SigV4 auth).
    remoteagentsigv_4: ?RegisteredRemoteAgentSigV4Details,
    /// ServiceNow-specific service details.
    servicenow: ?RegisteredServiceNowDetails,
    /// Slack-specific service details.
    slack: ?RegisteredSlackServiceDetails,

    pub const json_field_names = .{
        .azuredevops = "azuredevops",
        .azureidentity = "azureidentity",
        .github = "github",
        .gitlab = "gitlab",
        .mcpserver = "mcpserver",
        .mcpserverdatadog = "mcpserverdatadog",
        .mcpservergrafana = "mcpservergrafana",
        .mcpservernewrelic = "mcpservernewrelic",
        .mcpserversigv_4 = "mcpserversigv4",
        .mcpserversplunk = "mcpserversplunk",
        .pagerduty = "pagerduty",
        .remoteagent = "remoteagent",
        .remoteagentsigv_4 = "remoteagentsigv4",
        .servicenow = "servicenow",
        .slack = "slack",
    };
};
