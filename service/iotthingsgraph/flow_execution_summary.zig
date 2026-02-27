const FlowExecutionStatus = @import("flow_execution_status.zig").FlowExecutionStatus;

/// An object that contains summary information about a flow execution.
pub const FlowExecutionSummary = struct {
    /// The date and time when the flow execution summary was created.
    created_at: ?i64,

    /// The ID of the flow execution.
    flow_execution_id: ?[]const u8,

    /// The ID of the flow.
    flow_template_id: ?[]const u8,

    /// The current status of the flow execution.
    status: ?FlowExecutionStatus,

    /// The ID of the system instance that contains the flow.
    system_instance_id: ?[]const u8,

    /// The date and time when the flow execution summary was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .flow_execution_id = "flowExecutionId",
        .flow_template_id = "flowTemplateId",
        .status = "status",
        .system_instance_id = "systemInstanceId",
        .updated_at = "updatedAt",
    };
};
