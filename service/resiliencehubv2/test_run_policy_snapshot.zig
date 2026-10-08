const AvailabilitySlo = @import("availability_slo.zig").AvailabilitySlo;
const DataRecoveryTargets = @import("data_recovery_targets.zig").DataRecoveryTargets;
const MultiAzTargets = @import("multi_az_targets.zig").MultiAzTargets;
const MultiRegionTargets = @import("multi_region_targets.zig").MultiRegionTargets;

/// A snapshot of the resilience policy captured onto a test run from the
/// service when the run was started.
pub const TestRunPolicySnapshot = struct {
    /// The availability SLO targets.
    availability_slo: ?AvailabilitySlo = null,

    /// The data recovery targets.
    data_recovery: ?DataRecoveryTargets = null,

    /// The multi-AZ resilience targets.
    multi_az: ?MultiAzTargets = null,

    /// The multi-Region resilience targets.
    multi_region: ?MultiRegionTargets = null,

    /// The name of the policy.
    name: ?[]const u8 = null,

    /// The ARN of the policy.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_slo = "availabilitySlo",
        .data_recovery = "dataRecovery",
        .multi_az = "multiAz",
        .multi_region = "multiRegion",
        .name = "name",
        .policy_arn = "policyArn",
    };
};
