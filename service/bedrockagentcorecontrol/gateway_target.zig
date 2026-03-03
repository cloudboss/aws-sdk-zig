const CredentialProviderConfiguration = @import("credential_provider_configuration.zig").CredentialProviderConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const TargetStatus = @import("target_status.zig").TargetStatus;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

/// The gateway target.
pub const GatewayTarget = struct {
    /// The date and time at which the target was created.
    created_at: i64,

    /// The provider configurations.
    credential_provider_configurations: []const CredentialProviderConfiguration,

    /// The description for the gateway target.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway target.
    gateway_arn: []const u8,

    /// The last synchronization time.
    last_synchronized_at: ?i64 = null,

    /// The metadata configuration for HTTP header and query parameter propagation
    /// to and from this gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The name of the gateway target.
    name: []const u8,

    /// The status of the gateway target.
    status: TargetStatus,

    /// The status reasons for the target status.
    status_reasons: ?[]const []const u8 = null,

    target_configuration: TargetConfiguration,

    /// The target ID.
    target_id: []const u8,

    /// The date and time at which the target was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_arn = "gatewayArn",
        .last_synchronized_at = "lastSynchronizedAt",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .status = "status",
        .status_reasons = "statusReasons",
        .target_configuration = "targetConfiguration",
        .target_id = "targetId",
        .updated_at = "updatedAt",
    };
};
