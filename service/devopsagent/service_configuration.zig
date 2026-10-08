const AWSConfiguration = @import("aws_configuration.zig").AWSConfiguration;
const AzureConfiguration = @import("azure_configuration.zig").AzureConfiguration;
const AzureDevOpsConfiguration = @import("azure_dev_ops_configuration.zig").AzureDevOpsConfiguration;
const DynatraceConfiguration = @import("dynatrace_configuration.zig").DynatraceConfiguration;
const EventChannelConfiguration = @import("event_channel_configuration.zig").EventChannelConfiguration;
const GitHubConfiguration = @import("git_hub_configuration.zig").GitHubConfiguration;
const GitLabConfiguration = @import("git_lab_configuration.zig").GitLabConfiguration;
const MCPServerConfiguration = @import("mcp_server_configuration.zig").MCPServerConfiguration;
const MCPServerDatadogConfiguration = @import("mcp_server_datadog_configuration.zig").MCPServerDatadogConfiguration;
const MCPServerGrafanaConfiguration = @import("mcp_server_grafana_configuration.zig").MCPServerGrafanaConfiguration;
const MCPServerNewRelicConfiguration = @import("mcp_server_new_relic_configuration.zig").MCPServerNewRelicConfiguration;
const MCPServerSigV4Configuration = @import("mcp_server_sig_v4_configuration.zig").MCPServerSigV4Configuration;
const MCPServerSplunkConfiguration = @import("mcp_server_splunk_configuration.zig").MCPServerSplunkConfiguration;
const PagerDutyConfiguration = @import("pager_duty_configuration.zig").PagerDutyConfiguration;
const RemoteAgentConfiguration = @import("remote_agent_configuration.zig").RemoteAgentConfiguration;
const RemoteAgentSigV4Configuration = @import("remote_agent_sig_v4_configuration.zig").RemoteAgentSigV4Configuration;
const ServiceNowConfiguration = @import("service_now_configuration.zig").ServiceNowConfiguration;
const SlackConfiguration = @import("slack_configuration.zig").SlackConfiguration;
const SourceAwsConfiguration = @import("source_aws_configuration.zig").SourceAwsConfiguration;

/// Union of all supported service configuration types. Each service has its own
/// specific configuration structure.
pub const ServiceConfiguration = union(enum) {
    /// AWS monitor account configuration.
    aws: ?AWSConfiguration,
    /// Azure subscription integration configuration.
    azure: ?AzureConfiguration,
    /// Azure DevOps project integration configuration.
    azuredevops: ?AzureDevOpsConfiguration,
    /// Dynatrace monitoring integration configuration.
    dynatrace: ?DynatraceConfiguration,
    /// Event Channel instance integration configuration.
    event_channel: ?EventChannelConfiguration,
    /// GitHub repository integration configuration.
    github: ?GitHubConfiguration,
    /// GitLab project integration configuration.
    gitlab: ?GitLabConfiguration,
    /// MCP (Model Context Protocol) server integration configuration.
    mcpserver: ?MCPServerConfiguration,
    /// Datadog MCP server integration configuration.
    mcpserverdatadog: ?MCPServerDatadogConfiguration,
    /// Grafana MCP server integration configuration.
    mcpservergrafana: ?MCPServerGrafanaConfiguration,
    /// NewRelic instance integration configuration.
    mcpservernewrelic: ?MCPServerNewRelicConfiguration,
    /// SigV4-authenticated MCP server integration configuration.
    mcpserversigv_4: ?MCPServerSigV4Configuration,
    /// Splunk MCP server integration configuration.
    mcpserversplunk: ?MCPServerSplunkConfiguration,
    /// PagerDuty integration configuration
    pagerduty: ?PagerDutyConfiguration,
    /// Remote A2A agent integration configuration (token-based auth).
    remoteagent: ?RemoteAgentConfiguration,
    /// Remote A2A agent integration configuration (SigV4 auth).
    remoteagentsigv_4: ?RemoteAgentSigV4Configuration,
    /// ServiceNow instance integration configuration.
    servicenow: ?ServiceNowConfiguration,
    /// Slack workspace integration configuration.
    slack: ?SlackConfiguration,
    /// AWS source account configuration for monitoring resources.
    source_aws: ?SourceAwsConfiguration,

    pub const json_field_names = .{
        .aws = "aws",
        .azure = "azure",
        .azuredevops = "azuredevops",
        .dynatrace = "dynatrace",
        .event_channel = "eventChannel",
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
        .source_aws = "sourceAws",
    };
};
