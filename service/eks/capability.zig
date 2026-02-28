const aws = @import("aws");

const CapabilityConfigurationResponse = @import("capability_configuration_response.zig").CapabilityConfigurationResponse;
const CapabilityDeletePropagationPolicy = @import("capability_delete_propagation_policy.zig").CapabilityDeletePropagationPolicy;
const CapabilityHealth = @import("capability_health.zig").CapabilityHealth;
const CapabilityStatus = @import("capability_status.zig").CapabilityStatus;
const CapabilityType = @import("capability_type.zig").CapabilityType;

/// An object representing a managed capability in an Amazon EKS cluster. This
/// includes all configuration, status, and health information for the
/// capability.
pub const Capability = struct {
    /// The Amazon Resource Name (ARN) of the capability.
    arn: ?[]const u8,

    /// The unique name of the capability within the cluster.
    capability_name: ?[]const u8,

    /// The name of the Amazon EKS cluster that contains this capability.
    cluster_name: ?[]const u8,

    /// The configuration settings for the capability. The structure varies
    /// depending on the capability type.
    configuration: ?CapabilityConfigurationResponse,

    /// The Unix epoch timestamp in seconds for when the capability was created.
    created_at: ?i64,

    /// The delete propagation policy for the capability. Currently, the only
    /// supported value is `RETAIN`, which keeps all resources managed by the
    /// capability when the capability is deleted.
    delete_propagation_policy: ?CapabilityDeletePropagationPolicy,

    /// Health information for the capability, including any issues that may be
    /// affecting its operation.
    health: ?CapabilityHealth,

    /// The Unix epoch timestamp in seconds for when the capability was last
    /// modified.
    modified_at: ?i64,

    /// The Amazon Resource Name (ARN) of the IAM role that the capability uses to
    /// interact with Amazon Web Services services.
    role_arn: ?[]const u8,

    /// The current status of the capability. Valid values include:
    ///
    /// * `CREATING` – The capability is being created.
    ///
    /// * `ACTIVE` – The capability is running and available.
    ///
    /// * `UPDATING` – The capability is being updated.
    ///
    /// * `DELETING` – The capability is being deleted.
    ///
    /// * `CREATE_FAILED` – The capability creation failed.
    ///
    /// * `UPDATE_FAILED` – The capability update failed.
    ///
    /// * `DELETE_FAILED` – The capability deletion failed.
    status: ?CapabilityStatus,

    tags: ?[]const aws.map.StringMapEntry,

    /// The type of capability. Valid values are `ACK`, `ARGOCD`, or `KRO`.
    @"type": ?CapabilityType,

    /// The version of the capability software that is currently running.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .capability_name = "capabilityName",
        .cluster_name = "clusterName",
        .configuration = "configuration",
        .created_at = "createdAt",
        .delete_propagation_policy = "deletePropagationPolicy",
        .health = "health",
        .modified_at = "modifiedAt",
        .role_arn = "roleArn",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
    };
};
