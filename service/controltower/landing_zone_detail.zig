const LandingZoneDriftStatusSummary = @import("landing_zone_drift_status_summary.zig").LandingZoneDriftStatusSummary;
const RemediationType = @import("remediation_type.zig").RemediationType;
const LandingZoneStatus = @import("landing_zone_status.zig").LandingZoneStatus;

/// Information about the landing zone.
pub const LandingZoneDetail = struct {
    /// The ARN of the landing zone.
    arn: ?[]const u8,

    /// The drift status of the landing zone.
    drift_status: ?LandingZoneDriftStatusSummary,

    /// The latest available version of the landing zone.
    latest_available_version: ?[]const u8,

    /// The landing zone manifest JSON text file that specifies the landing zone
    /// configurations.
    manifest: []const u8,

    /// The types of remediation actions configured for the landing zone, such as
    /// automatic drift correction or compliance enforcement.
    remediation_types: ?[]const RemediationType,

    /// The landing zone deployment status. One of `ACTIVE`, `PROCESSING`, `FAILED`.
    status: ?LandingZoneStatus,

    /// The landing zone's current deployed version.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .drift_status = "driftStatus",
        .latest_available_version = "latestAvailableVersion",
        .manifest = "manifest",
        .remediation_types = "remediationTypes",
        .status = "status",
        .version = "version",
    };
};
