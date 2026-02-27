const aws = @import("aws");

const AIAgentConfigurationData = @import("ai_agent_configuration_data.zig").AIAgentConfigurationData;
const SessionIntegrationConfiguration = @import("session_integration_configuration.zig").SessionIntegrationConfiguration;
const OrchestratorConfigurationEntry = @import("orchestrator_configuration_entry.zig").OrchestratorConfigurationEntry;
const Origin = @import("origin.zig").Origin;
const TagFilter = @import("tag_filter.zig").TagFilter;

/// Information about the session.
pub const SessionData = struct {
    /// The configuration of the AI Agents (mapped by AI Agent Type to AI Agent
    /// version) that should be used by Amazon Q in Connect for this Session.
    ai_agent_configuration: ?[]const aws.map.MapEntry(AIAgentConfigurationData),

    /// The description of the session.
    description: ?[]const u8,

    /// The configuration information for the session integration.
    integration_configuration: ?SessionIntegrationConfiguration,

    /// The name of the session.
    name: []const u8,

    /// The list of orchestrator configurations for the session.
    orchestrator_configuration_list: ?[]const OrchestratorConfigurationEntry,

    /// The origin of the Session to be listed. `SYSTEM` for a default Session
    /// created by Amazon Q in Connect or `CUSTOMER` for a Session created by
    /// calling
    /// [CreateSession](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_CreateSession.html) API.
    origin: ?Origin,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The identifier of the session.
    session_id: []const u8,

    /// An object that can be used to specify Tag conditions.
    tag_filter: ?TagFilter,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .ai_agent_configuration = "aiAgentConfiguration",
        .description = "description",
        .integration_configuration = "integrationConfiguration",
        .name = "name",
        .orchestrator_configuration_list = "orchestratorConfigurationList",
        .origin = "origin",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .tag_filter = "tagFilter",
        .tags = "tags",
    };
};
