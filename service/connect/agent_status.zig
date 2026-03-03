const aws = @import("aws");

const AgentStatusState = @import("agent_status_state.zig").AgentStatusState;
const AgentStatusType = @import("agent_status_type.zig").AgentStatusType;

/// Contains information about an agent status.
pub const AgentStatus = struct {
    /// The Amazon Resource Name (ARN) of the agent status.
    agent_status_arn: ?[]const u8 = null,

    /// The identifier of the agent status.
    agent_status_id: ?[]const u8 = null,

    /// The description of the agent status.
    description: ?[]const u8 = null,

    /// The display order of the agent status.
    display_order: ?i32 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the agent status.
    name: ?[]const u8 = null,

    /// The state of the agent status.
    state: ?AgentStatusState = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of agent status.
    @"type": ?AgentStatusType = null,

    pub const json_field_names = .{
        .agent_status_arn = "AgentStatusARN",
        .agent_status_id = "AgentStatusId",
        .description = "Description",
        .display_order = "DisplayOrder",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .state = "State",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
