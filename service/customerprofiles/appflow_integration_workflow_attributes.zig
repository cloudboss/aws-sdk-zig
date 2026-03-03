const SourceConnectorType = @import("source_connector_type.zig").SourceConnectorType;

/// Structure holding all `APPFLOW_INTEGRATION` specific workflow
/// attributes.
pub const AppflowIntegrationWorkflowAttributes = struct {
    /// The name of the AppFlow connector profile used for ingestion.
    connector_profile_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role. Customer Profiles assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: ?[]const u8 = null,

    /// Specifies the source connector type, such as Salesforce, ServiceNow, and
    /// Marketo.
    /// Indicates source of ingestion.
    source_connector_type: SourceConnectorType,

    pub const json_field_names = .{
        .connector_profile_name = "ConnectorProfileName",
        .role_arn = "RoleArn",
        .source_connector_type = "SourceConnectorType",
    };
};
