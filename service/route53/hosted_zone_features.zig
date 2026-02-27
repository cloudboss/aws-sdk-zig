const AcceleratedRecoveryStatus = @import("accelerated_recovery_status.zig").AcceleratedRecoveryStatus;
const HostedZoneFailureReasons = @import("hosted_zone_failure_reasons.zig").HostedZoneFailureReasons;

/// Represents the features configuration for a hosted zone, including the
/// status of various features and any associated failure reasons.
pub const HostedZoneFeatures = struct {
    /// The current status of accelerated recovery for the hosted zone.
    accelerated_recovery_status: ?AcceleratedRecoveryStatus,

    /// Information about any failures that occurred when attempting to enable or
    /// configure features for the hosted zone.
    failure_reasons: ?HostedZoneFailureReasons,
};
