const aws = @import("aws");

const ConnectorType = @import("connector_type.zig").ConnectorType;
const FlowStatus = @import("flow_status.zig").FlowStatus;
const ExecutionDetails = @import("execution_details.zig").ExecutionDetails;
const TriggerType = @import("trigger_type.zig").TriggerType;

/// The properties of the flow, such as its source, destination, trigger type,
/// and so on.
pub const FlowDefinition = struct {
    /// Specifies when the flow was created.
    created_at: ?i64,

    /// The ARN of the user who created the flow.
    created_by: ?[]const u8,

    /// A user-entered description of the flow.
    description: ?[]const u8,

    /// The label of the destination connector in the flow.
    destination_connector_label: ?[]const u8,

    /// Specifies the destination connector type, such as Salesforce, Amazon S3,
    /// Amplitude, and so on.
    destination_connector_type: ?ConnectorType,

    /// The flow's Amazon Resource Name (ARN).
    flow_arn: ?[]const u8,

    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: ?[]const u8,

    /// Indicates the current status of the flow.
    flow_status: ?FlowStatus,

    /// Describes the details of the most recent flow run.
    last_run_execution_details: ?ExecutionDetails,

    /// Specifies when the flow was last updated.
    last_updated_at: ?i64,

    /// Specifies the account user name that most recently updated the flow.
    last_updated_by: ?[]const u8,

    /// The label of the source connector in the flow.
    source_connector_label: ?[]const u8,

    /// Specifies the source connector type, such as Salesforce, Amazon S3,
    /// Amplitude,
    /// and so on.
    source_connector_type: ?ConnectorType,

    /// The tags used to organize, track, or control access for your flow.
    tags: ?[]const aws.map.StringMapEntry,

    /// Specifies the type of flow trigger. This can be `OnDemand`,
    /// `Scheduled`, or `Event`.
    trigger_type: ?TriggerType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .destination_connector_label = "destinationConnectorLabel",
        .destination_connector_type = "destinationConnectorType",
        .flow_arn = "flowArn",
        .flow_name = "flowName",
        .flow_status = "flowStatus",
        .last_run_execution_details = "lastRunExecutionDetails",
        .last_updated_at = "lastUpdatedAt",
        .last_updated_by = "lastUpdatedBy",
        .source_connector_label = "sourceConnectorLabel",
        .source_connector_type = "sourceConnectorType",
        .tags = "tags",
        .trigger_type = "triggerType",
    };
};
