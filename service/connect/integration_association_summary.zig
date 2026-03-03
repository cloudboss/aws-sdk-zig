const IntegrationType = @import("integration_type.zig").IntegrationType;
const SourceType = @import("source_type.zig").SourceType;

/// Contains summary information about the associated AppIntegrations.
pub const IntegrationAssociationSummary = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the AppIntegration.
    integration_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the AppIntegration association.
    integration_association_arn: ?[]const u8 = null,

    /// The identifier for the AppIntegration association.
    integration_association_id: ?[]const u8 = null,

    /// The integration type.
    integration_type: ?IntegrationType = null,

    /// The user-provided, friendly name for the external application.
    source_application_name: ?[]const u8 = null,

    /// The URL for the external application.
    source_application_url: ?[]const u8 = null,

    /// The name of the source.
    source_type: ?SourceType = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .integration_arn = "IntegrationArn",
        .integration_association_arn = "IntegrationAssociationArn",
        .integration_association_id = "IntegrationAssociationId",
        .integration_type = "IntegrationType",
        .source_application_name = "SourceApplicationName",
        .source_application_url = "SourceApplicationUrl",
        .source_type = "SourceType",
    };
};
