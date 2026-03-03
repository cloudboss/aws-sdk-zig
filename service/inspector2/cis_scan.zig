const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;
const CisScanStatus = @import("cis_scan_status.zig").CisScanStatus;
const CisTargets = @import("cis_targets.zig").CisTargets;

/// The CIS scan.
pub const CisScan = struct {
    /// The CIS scan's failed checks.
    failed_checks: ?i32 = null,

    /// The CIS scan's ARN.
    scan_arn: []const u8,

    /// The CIS scan's configuration ARN.
    scan_configuration_arn: []const u8,

    /// The CIS scan's date.
    scan_date: ?i64 = null,

    /// The the name of the scan configuration that's associated with this scan.
    scan_name: ?[]const u8 = null,

    /// The account or organization that schedules the CIS scan.
    scheduled_by: ?[]const u8 = null,

    /// The security level for the CIS scan. Security level refers to the Benchmark
    /// levels that
    /// CIS assigns to a profile.
    security_level: ?CisSecurityLevel = null,

    /// The CIS scan's status.
    status: ?CisScanStatus = null,

    /// The CIS scan's targets.
    targets: ?CisTargets = null,

    /// The CIS scan's total checks.
    total_checks: ?i32 = null,

    pub const json_field_names = .{
        .failed_checks = "failedChecks",
        .scan_arn = "scanArn",
        .scan_configuration_arn = "scanConfigurationArn",
        .scan_date = "scanDate",
        .scan_name = "scanName",
        .scheduled_by = "scheduledBy",
        .security_level = "securityLevel",
        .status = "status",
        .targets = "targets",
        .total_checks = "totalChecks",
    };
};
