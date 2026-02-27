const AgentStatusType = @import("agent_status_type.zig").AgentStatusType;

/// Summary information for an agent status.
pub const AgentStatusSummary = struct {
    /// The Amazon Resource Name (ARN) for the agent status.
    arn: ?[]const u8,

    /// The identifier for an agent status.
    id: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the agent status.
    name: ?[]const u8,

    /// The type of the agent status.
    type: ?AgentStatusType,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .type = "Type",
    };
};
