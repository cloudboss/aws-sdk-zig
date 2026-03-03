const aws = @import("aws");

const Schedule = @import("schedule.zig").Schedule;
const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;
const CisTargets = @import("cis_targets.zig").CisTargets;

/// The CIS scan configuration.
pub const CisScanConfiguration = struct {
    /// The CIS scan configuration's owner ID.
    owner_id: ?[]const u8 = null,

    /// The CIS scan configuration's scan configuration ARN.
    scan_configuration_arn: []const u8,

    /// The name of the CIS scan configuration.
    scan_name: ?[]const u8 = null,

    /// The CIS scan configuration's schedule.
    schedule: ?Schedule = null,

    /// The CIS scan configuration's security level.
    security_level: ?CisSecurityLevel = null,

    /// The CIS scan configuration's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The CIS scan configuration's targets.
    targets: ?CisTargets = null,

    pub const json_field_names = .{
        .owner_id = "ownerId",
        .scan_configuration_arn = "scanConfigurationArn",
        .scan_name = "scanName",
        .schedule = "schedule",
        .security_level = "securityLevel",
        .tags = "tags",
        .targets = "targets",
    };
};
