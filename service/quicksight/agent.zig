const AgentLifecycle = @import("agent_lifecycle.zig").AgentLifecycle;
const AgentStatus = @import("agent_status.zig").AgentStatus;
const CustomPromptInterface = @import("custom_prompt_interface.zig").CustomPromptInterface;

/// An agent resource in Amazon QuickSight that provides AI-powered
/// conversational experiences.
pub const Agent = struct {
    /// The Amazon Resource Names (ARNs) of the action connectors attached to the
    /// agent.
    action_connectors: ?[]const []const u8 = null,

    /// The unique identifier for the agent.
    agent_id: []const u8,

    /// The lifecycle state of the agent. Valid values are `PREVIEW` and
    /// `PUBLISHED`.
    agent_lifecycle: AgentLifecycle,

    /// The status of the agent.
    agent_status: AgentStatus,

    /// The Amazon Resource Name (ARN) of the agent.
    arn: []const u8,

    /// The date and time that the agent was created.
    created_at: i64,

    /// The identity of the user who created the agent.
    creator: []const u8,

    /// The custom prompt interface configuration for the agent.
    custom_prompt_interface: ?CustomPromptInterface = null,

    /// A description of the agent.
    description: ?[]const u8 = null,

    /// An error message associated with the agent, if applicable.
    error_message: ?[]const u8 = null,

    /// The icon identifier for the agent.
    icon_id: ?[]const u8 = null,

    /// The name of the agent.
    name: []const u8,

    /// The Amazon Resource Names (ARNs) of the spaces attached to the agent.
    spaces: ?[]const []const u8 = null,

    /// A list of starter prompts that are displayed to users when they begin
    /// interacting with the agent.
    starter_prompts: ?[]const []const u8 = null,

    /// The date and time that the agent was last updated.
    updated_at: i64,

    /// The welcome message that is displayed when a user starts a conversation with
    /// the agent.
    welcome_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_connectors = "ActionConnectors",
        .agent_id = "AgentId",
        .agent_lifecycle = "AgentLifecycle",
        .agent_status = "AgentStatus",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .creator = "Creator",
        .custom_prompt_interface = "CustomPromptInterface",
        .description = "Description",
        .error_message = "ErrorMessage",
        .icon_id = "IconId",
        .name = "Name",
        .spaces = "Spaces",
        .starter_prompts = "StarterPrompts",
        .updated_at = "UpdatedAt",
        .welcome_message = "WelcomeMessage",
    };
};
