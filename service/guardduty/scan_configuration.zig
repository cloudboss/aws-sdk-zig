const IncrementalScanDetails = @import("incremental_scan_details.zig").IncrementalScanDetails;
const ScanConfigurationRecoveryPoint = @import("scan_configuration_recovery_point.zig").ScanConfigurationRecoveryPoint;
const TriggerDetails = @import("trigger_details.zig").TriggerDetails;

/// Contains information about the configuration used for the malware scan.
pub const ScanConfiguration = struct {
    /// Information about the incremental scan configuration, if applicable.
    incremental_scan_details: ?IncrementalScanDetails,

    /// Information about the recovery point configuration used for the scan, if
    /// applicable.
    recovery_point: ?ScanConfigurationRecoveryPoint,

    /// Amazon Resource Name (ARN) of the IAM role that should contain the required
    /// permissions for the scan.
    role: ?[]const u8,

    /// Information about the entity that triggered the malware scan.
    trigger_details: ?TriggerDetails,

    pub const json_field_names = .{
        .incremental_scan_details = "IncrementalScanDetails",
        .recovery_point = "RecoveryPoint",
        .role = "Role",
        .trigger_details = "TriggerDetails",
    };
};
