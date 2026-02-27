const DataIntegrationFlowExecutionOutputMetadata = @import("data_integration_flow_execution_output_metadata.zig").DataIntegrationFlowExecutionOutputMetadata;
const DataIntegrationFlowExecutionSourceInfo = @import("data_integration_flow_execution_source_info.zig").DataIntegrationFlowExecutionSourceInfo;
const DataIntegrationFlowExecutionStatus = @import("data_integration_flow_execution_status.zig").DataIntegrationFlowExecutionStatus;

/// The flow execution details.
pub const DataIntegrationFlowExecution = struct {
    /// The flow execution end timestamp.
    end_time: ?i64,

    /// The flow executionId.
    execution_id: []const u8,

    /// The flow execution's flowName.
    flow_name: []const u8,

    /// The flow execution's instanceId.
    instance_id: []const u8,

    /// The failure message (if any) of failed flow execution.
    message: ?[]const u8,

    /// The flow execution output metadata.
    output_metadata: ?DataIntegrationFlowExecutionOutputMetadata,

    /// The source information for a flow execution.
    source_info: ?DataIntegrationFlowExecutionSourceInfo,

    /// The flow execution start timestamp.
    start_time: ?i64,

    /// The status of flow execution.
    status: ?DataIntegrationFlowExecutionStatus,

    pub const json_field_names = .{
        .end_time = "endTime",
        .execution_id = "executionId",
        .flow_name = "flowName",
        .instance_id = "instanceId",
        .message = "message",
        .output_metadata = "outputMetadata",
        .source_info = "sourceInfo",
        .start_time = "startTime",
        .status = "status",
    };
};
