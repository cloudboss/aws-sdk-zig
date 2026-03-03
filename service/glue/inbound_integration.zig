const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationConfig = @import("integration_config.zig").IntegrationConfig;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

/// A structure for an integration that writes data into a resource.
pub const InboundIntegration = struct {
    /// The time that the integration was created, in UTC.
    create_time: i64,

    /// A list of errors associated with the integration.
    errors: ?[]const IntegrationError = null,

    /// The ARN of the zero-ETL integration.
    integration_arn: []const u8,

    /// Properties associated with the integration.
    integration_config: ?IntegrationConfig = null,

    /// The ARN of the source resource for the integration.
    source_arn: []const u8,

    /// The possible statuses are:
    ///
    /// * CREATING: The integration is being created.
    ///
    /// * ACTIVE: The integration creation succeeds.
    ///
    /// * MODIFYING: The integration is being modified.
    ///
    /// * FAILED: The integration creation fails.
    ///
    /// * DELETING: The integration is deleted.
    ///
    /// * SYNCING: The integration is synchronizing.
    ///
    /// * NEEDS_ATTENTION: The integration needs attention, such as synchronization.
    status: IntegrationStatus,

    /// The ARN of the target resource for the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .errors = "Errors",
        .integration_arn = "IntegrationArn",
        .integration_config = "IntegrationConfig",
        .source_arn = "SourceArn",
        .status = "Status",
        .target_arn = "TargetArn",
    };
};
