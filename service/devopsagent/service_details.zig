const RegisteredAzureIdentityDetails = @import("registered_azure_identity_details.zig").RegisteredAzureIdentityDetails;
const DynatraceServiceDetails = @import("dynatrace_service_details.zig").DynatraceServiceDetails;
const EventChannelDetails = @import("event_channel_details.zig").EventChannelDetails;
const GitLabDetails = @import("git_lab_details.zig").GitLabDetails;
const MCPServerDetails = @import("mcp_server_details.zig").MCPServerDetails;
const DatadogServiceDetails = @import("datadog_service_details.zig").DatadogServiceDetails;
const GrafanaServiceDetails = @import("grafana_service_details.zig").GrafanaServiceDetails;
const NewRelicServiceDetails = @import("new_relic_service_details.zig").NewRelicServiceDetails;
const MCPServerSigV4ServiceDetails = @import("mcp_server_sig_v4_service_details.zig").MCPServerSigV4ServiceDetails;
const PagerDutyDetails = @import("pager_duty_details.zig").PagerDutyDetails;
const RemoteAgentServiceDetails = @import("remote_agent_service_details.zig").RemoteAgentServiceDetails;
const RemoteAgentSigV4ServiceDetails = @import("remote_agent_sig_v4_service_details.zig").RemoteAgentSigV4ServiceDetails;
const ServiceNowServiceDetails = @import("service_now_service_details.zig").ServiceNowServiceDetails;

/// Union of service-specific configuration details for service registration.
pub const ServiceDetails = union(enum) {
    /// Azure integration with AWS Outbound Identity Federation specific service
    /// details.
    azureidentity: ?RegisteredAzureIdentityDetails,
    /// Dynatrace-specific service details.
    dynatrace: ?DynatraceServiceDetails,
    /// Event Channel specific service details.
    event_channel: ?EventChannelDetails,
    /// GitLab-specific service details.
    gitlab: ?GitLabDetails,
    /// MCP server-specific service details.
    mcpserver: ?MCPServerDetails,
    /// Datadog MCP server-specific service details.
    mcpserverdatadog: ?DatadogServiceDetails,
    /// Datadog MCP server-specific service details.
    mcpservergrafana: ?GrafanaServiceDetails,
    /// New Relic-specific service details.
    mcpservernewrelic: ?NewRelicServiceDetails,
    /// SigV4-authenticated MCP server-specific service details.
    mcpserversigv_4: ?MCPServerSigV4ServiceDetails,
    /// Splunk MCP server-specific service details.
    mcpserversplunk: ?MCPServerDetails,
    /// PagerDuty specific service details.
    pagerduty: ?PagerDutyDetails,
    /// Remote A2A agent service details (token-based auth).
    remoteagent: ?RemoteAgentServiceDetails,
    /// Remote A2A agent service details (SigV4 auth).
    remoteagentsigv_4: ?RemoteAgentSigV4ServiceDetails,
    /// ServiceNow-specific service details.
    servicenow: ?ServiceNowServiceDetails,

    pub const json_field_names = .{
        .azureidentity = "azureidentity",
        .dynatrace = "dynatrace",
        .event_channel = "eventChannel",
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
    };
};
