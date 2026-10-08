const std = @import("std");

/// Enumeration of all supported service types, combining OAuth 3-legged, client
/// credentials, and simple token authentication methods.
pub const Service = enum {
    github,
    slack,
    azure,
    azure_devops,
    dynatrace,
    servicenow,
    pagerduty,
    gitlab,
    eventchannel,
    /// NewRelic MCP server.
    mcp_server_newrelic,
    /// Grafana MCP server.
    mcp_server_grafana,
    /// Datadog MCP server.
    mcp_server_datadog,
    /// Model Context Protocol server.
    mcp_server,
    /// Splunk MCP server.
    mcp_server_splunk,
    /// Azure Service with AWS Outbound Identity Federation.
    azure_identity,
    /// SigV4-authenticated MCP server.
    mcp_server_sigv4,
    /// Remote A2A agent with token-based authentication (API key or OAuth).
    remote_agent,
    /// Remote A2A agent with SigV4 authentication.
    remote_agent_sigv4,

    pub const json_field_names = .{
        .github = "github",
        .slack = "slack",
        .azure = "azure",
        .azure_devops = "azuredevops",
        .dynatrace = "dynatrace",
        .servicenow = "servicenow",
        .pagerduty = "pagerduty",
        .gitlab = "gitlab",
        .eventchannel = "eventChannel",
        .mcp_server_newrelic = "mcpservernewrelic",
        .mcp_server_grafana = "mcpservergrafana",
        .mcp_server_datadog = "mcpserverdatadog",
        .mcp_server = "mcpserver",
        .mcp_server_splunk = "mcpserversplunk",
        .azure_identity = "azureidentity",
        .mcp_server_sigv4 = "mcpserversigv4",
        .remote_agent = "remoteagent",
        .remote_agent_sigv4 = "remoteagentsigv4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .github => "github",
            .slack => "slack",
            .azure => "azure",
            .azure_devops => "azuredevops",
            .dynatrace => "dynatrace",
            .servicenow => "servicenow",
            .pagerduty => "pagerduty",
            .gitlab => "gitlab",
            .eventchannel => "eventChannel",
            .mcp_server_newrelic => "mcpservernewrelic",
            .mcp_server_grafana => "mcpservergrafana",
            .mcp_server_datadog => "mcpserverdatadog",
            .mcp_server => "mcpserver",
            .mcp_server_splunk => "mcpserversplunk",
            .azure_identity => "azureidentity",
            .mcp_server_sigv4 => "mcpserversigv4",
            .remote_agent => "remoteagent",
            .remote_agent_sigv4 => "remoteagentsigv4",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
