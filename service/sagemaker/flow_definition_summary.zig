const FlowDefinitionStatus = @import("flow_definition_status.zig").FlowDefinitionStatus;

/// Contains summary information about the flow definition.
pub const FlowDefinitionSummary = struct {
    /// The timestamp when SageMaker created the flow definition.
    creation_time: i64,

    /// The reason why the flow definition creation failed. A failure reason is
    /// returned only when the flow definition status is `Failed`.
    failure_reason: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the flow definition.
    flow_definition_arn: []const u8,

    /// The name of the flow definition.
    flow_definition_name: []const u8,

    /// The status of the flow definition. Valid values:
    flow_definition_status: FlowDefinitionStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .flow_definition_arn = "FlowDefinitionArn",
        .flow_definition_name = "FlowDefinitionName",
        .flow_definition_status = "FlowDefinitionStatus",
    };
};
