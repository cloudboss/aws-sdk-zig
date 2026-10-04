const FlowPublishState = @import("flow_publish_state.zig").FlowPublishState;
const StepAliasMapping = @import("step_alias_mapping.zig").StepAliasMapping;

/// The full details of a flow, including its definition specifying the steps.
pub const FlowDetail = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The identifier of the principal who created the flow.
    created_by: ?[]const u8 = null,

    /// The time this flow was created.
    created_time: i64,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// The definition of the flow, specifying the steps and configurations. This is
    /// the flow definition in Quick Flow's internal format. The format is subject
    /// to change.
    flow_definition: []const u8,

    /// The unique identifier of the flow.
    flow_id: []const u8,

    /// The identifier of the last principal who updated the flow.
    last_updated_by: ?[]const u8 = null,

    /// The last time this flow was modified.
    last_updated_time: ?i64 = null,

    /// The display name of the flow.
    name: []const u8,

    /// The publish state of the flow. Valid values are `DRAFT`, `PUBLISHED`,
    /// or `PENDING_APPROVAL`.
    publish_state: FlowPublishState,

    /// A list of step alias mappings for the flow.
    step_aliases: ?[]const StepAliasMapping = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .description = "Description",
        .flow_definition = "FlowDefinition",
        .flow_id = "FlowId",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .publish_state = "PublishState",
        .step_aliases = "StepAliases",
    };
};
