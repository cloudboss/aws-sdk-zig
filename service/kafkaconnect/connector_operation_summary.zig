const ConnectorOperationState = @import("connector_operation_state.zig").ConnectorOperationState;
const ConnectorOperationType = @import("connector_operation_type.zig").ConnectorOperationType;

/// Summary of a connector operation.
pub const ConnectorOperationSummary = struct {
    /// The Amazon Resource Name (ARN) of the connector operation.
    connector_operation_arn: ?[]const u8 = null,

    /// The state of the connector operation.
    connector_operation_state: ?ConnectorOperationState = null,

    /// The type of connector operation performed.
    connector_operation_type: ?ConnectorOperationType = null,

    /// The time when operation was created.
    creation_time: ?i64 = null,

    /// The time when operation ended.
    end_time: ?i64 = null,

    pub const json_field_names = .{
        .connector_operation_arn = "connectorOperationArn",
        .connector_operation_state = "connectorOperationState",
        .connector_operation_type = "connectorOperationType",
        .creation_time = "creationTime",
        .end_time = "endTime",
    };
};
