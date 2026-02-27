const ConnectorOperationState = @import("connector_operation_state.zig").ConnectorOperationState;
const ConnectorOperationType = @import("connector_operation_type.zig").ConnectorOperationType;

/// Summary of a connector operation.
pub const ConnectorOperationSummary = struct {
    /// The Amazon Resource Name (ARN) of the connector operation.
    connector_operation_arn: ?[]const u8,

    /// The state of the connector operation.
    connector_operation_state: ?ConnectorOperationState,

    /// The type of connector operation performed.
    connector_operation_type: ?ConnectorOperationType,

    /// The time when operation was created.
    creation_time: ?i64,

    /// The time when operation ended.
    end_time: ?i64,

    pub const json_field_names = .{
        .connector_operation_arn = "connectorOperationArn",
        .connector_operation_state = "connectorOperationState",
        .connector_operation_type = "connectorOperationType",
        .creation_time = "creationTime",
        .end_time = "endTime",
    };
};
