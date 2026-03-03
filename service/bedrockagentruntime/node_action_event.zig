/// Contains information about an action (operation) called by a node during
/// execution.
pub const NodeActionEvent = struct {
    /// The name of the node that called the operation.
    node_name: []const u8,

    /// The name of the operation that the node called.
    operation_name: []const u8,

    /// The request payload sent to the downstream service.
    operation_request: ?[]const u8 = null,

    /// The response payload received from the downstream service.
    operation_response: ?[]const u8 = null,

    /// The ID of the request that the node made to the operation.
    request_id: []const u8,

    /// The name of the service that the node called.
    service_name: []const u8,

    /// The date and time that the operation was called.
    timestamp: i64,

    pub const json_field_names = .{
        .node_name = "nodeName",
        .operation_name = "operationName",
        .operation_request = "operationRequest",
        .operation_response = "operationResponse",
        .request_id = "requestId",
        .service_name = "serviceName",
        .timestamp = "timestamp",
    };
};
