const aws = @import("aws");

const AvailabilitySlo = @import("availability_slo.zig").AvailabilitySlo;
const DataRecoveryTargets = @import("data_recovery_targets.zig").DataRecoveryTargets;
const MultiAzTargets = @import("multi_az_targets.zig").MultiAzTargets;
const MultiRegionTargets = @import("multi_region_targets.zig").MultiRegionTargets;

/// Represents a resilience policy that defines availability and disaster
/// recovery requirements.
pub const Policy = struct {
    /// The number of services associated with this policy.
    associated_service_count: ?i32 = null,

    /// The availability SLO defined in the policy.
    availability_slo: ?AvailabilitySlo = null,

    /// The timestamp when the policy was created.
    created_at: ?i64 = null,

    /// The data recovery targets defined in the policy.
    data_recovery: ?DataRecoveryTargets = null,

    description: ?[]const u8 = null,

    kms_key_id: ?[]const u8 = null,

    /// The multi-AZ disaster recovery targets defined in the policy.
    multi_az: ?MultiAzTargets = null,

    /// The multi-Region disaster recovery targets defined in the policy.
    multi_region: ?MultiRegionTargets = null,

    name: []const u8,

    /// The identifier of the organization this policy is shared with.
    organization_id: ?[]const u8 = null,

    policy_arn: []const u8,

    /// Specifies whether cross-account sharing is enabled.
    sharing_enabled: ?bool = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the policy was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .associated_service_count = "associatedServiceCount",
        .availability_slo = "availabilitySlo",
        .created_at = "createdAt",
        .data_recovery = "dataRecovery",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .multi_az = "multiAz",
        .multi_region = "multiRegion",
        .name = "name",
        .organization_id = "organizationId",
        .policy_arn = "policyArn",
        .sharing_enabled = "sharingEnabled",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
