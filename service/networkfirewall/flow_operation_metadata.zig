const FlowOperationStatus = @import("flow_operation_status.zig").FlowOperationStatus;
const FlowOperationType = @import("flow_operation_type.zig").FlowOperationType;

/// An array of objects with metadata about the requested `FlowOperation`.
pub const FlowOperationMetadata = struct {
    /// A unique identifier for the flow operation. This ID is returned in the
    /// responses to start and list commands. You provide to describe commands.
    flow_operation_id: ?[]const u8 = null,

    /// Returns the status of the flow operation. This string is returned in the
    /// responses to start, list, and describe commands.
    ///
    /// If the status is `COMPLETED_WITH_ERRORS`, results may be returned with any
    /// number of `Flows` missing from the response.
    /// If the status is `FAILED`, `Flows` returned will be empty.
    flow_operation_status: ?FlowOperationStatus = null,

    /// Defines the type of `FlowOperation`.
    flow_operation_type: ?FlowOperationType = null,

    /// A timestamp indicating when the Suricata engine identified flows impacted by
    /// an operation.
    flow_request_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .flow_operation_id = "FlowOperationId",
        .flow_operation_status = "FlowOperationStatus",
        .flow_operation_type = "FlowOperationType",
        .flow_request_timestamp = "FlowRequestTimestamp",
    };
};
