const AdministrativeOverride = @import("administrative_override.zig").AdministrativeOverride;
const AnomalyDetection = @import("anomaly_detection.zig").AnomalyDetection;
const TargetDescription = @import("target_description.zig").TargetDescription;
const TargetHealth = @import("target_health.zig").TargetHealth;

/// Information about the health of a target.
pub const TargetHealthDescription = struct {
    /// The administrative override information for the target.
    administrative_override: ?AdministrativeOverride,

    /// The anomaly detection result for the target.
    ///
    /// If no anomalies were detected, the result is `normal`.
    ///
    /// If anomalies were detected, the result is `anomalous`.
    anomaly_detection: ?AnomalyDetection,

    /// The port to use to connect with the target.
    health_check_port: ?[]const u8,

    /// The description of the target.
    target: ?TargetDescription,

    /// The health information for the target.
    target_health: ?TargetHealth,
};
