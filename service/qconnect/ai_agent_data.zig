const aws = @import("aws");

const AIAgentConfiguration = @import("ai_agent_configuration.zig").AIAgentConfiguration;
const Origin = @import("origin.zig").Origin;
const Status = @import("status.zig").Status;
const AIAgentType = @import("ai_agent_type.zig").AIAgentType;
const VisibilityStatus = @import("visibility_status.zig").VisibilityStatus;

/// The data for the AI Agent.
pub const AIAgentData = struct {
    /// The Amazon Resource Name (ARN) of the AI agent.
    ai_agent_arn: []const u8,

    /// The identifier of the AI Agent.
    ai_agent_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// Configuration for the AI Agent.
    configuration: AIAgentConfiguration,

    /// The description of the AI Agent.
    description: ?[]const u8 = null,

    /// The time the AI Agent was last modified.
    modified_time: ?i64 = null,

    /// The name of the AI Agent.
    name: []const u8,

    /// Specifies the origin of the AI Agent. `SYSTEM` for a default AI Agent
    /// created by Q in Connect or `CUSTOMER` for an AI Agent created by calling AI
    /// Agent creation APIs.
    origin: ?Origin = null,

    /// The status of the AI Agent.
    status: ?Status = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the AI Agent.
    @"type": AIAgentType,

    /// The visibility status of the AI Agent.
    visibility_status: VisibilityStatus,

    pub const json_field_names = .{
        .ai_agent_arn = "aiAgentArn",
        .ai_agent_id = "aiAgentId",
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .configuration = "configuration",
        .description = "description",
        .modified_time = "modifiedTime",
        .name = "name",
        .origin = "origin",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
        .visibility_status = "visibilityStatus",
    };
};
