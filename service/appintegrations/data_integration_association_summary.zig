const ExecutionConfiguration = @import("execution_configuration.zig").ExecutionConfiguration;
const LastExecutionStatus = @import("last_execution_status.zig").LastExecutionStatus;

/// Summary information about the DataIntegration association.
pub const DataIntegrationAssociationSummary = struct {
    /// The identifier for the client that is associated with the DataIntegration
    /// association.
    client_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the DataIntegration.
    data_integration_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the DataIntegration association.
    data_integration_association_arn: ?[]const u8,

    /// The URI of the data destination.
    destination_uri: ?[]const u8,

    execution_configuration: ?ExecutionConfiguration,

    /// The execution status of the last job.
    last_execution_status: ?LastExecutionStatus,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .data_integration_arn = "DataIntegrationArn",
        .data_integration_association_arn = "DataIntegrationAssociationArn",
        .destination_uri = "DestinationURI",
        .execution_configuration = "ExecutionConfiguration",
        .last_execution_status = "LastExecutionStatus",
    };
};
