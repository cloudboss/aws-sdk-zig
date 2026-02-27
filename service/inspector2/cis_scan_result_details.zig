const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;
const CisFindingStatus = @import("cis_finding_status.zig").CisFindingStatus;

/// The CIS scan result details.
pub const CisScanResultDetails = struct {
    /// The CIS scan result details' account ID.
    account_id: ?[]const u8,

    /// The account ID that's associated with the CIS scan result details.
    check_description: ?[]const u8,

    /// The CIS scan result details' check ID.
    check_id: ?[]const u8,

    /// The CIS scan result details' finding ARN.
    finding_arn: ?[]const u8,

    /// The CIS scan result details' level.
    level: ?CisSecurityLevel,

    /// The CIS scan result details' platform.
    platform: ?[]const u8,

    /// The CIS scan result details' remediation.
    remediation: ?[]const u8,

    /// The CIS scan result details' scan ARN.
    scan_arn: []const u8,

    /// The CIS scan result details' status.
    status: ?CisFindingStatus,

    /// The CIS scan result details' status reason.
    status_reason: ?[]const u8,

    /// The CIS scan result details' target resource ID.
    target_resource_id: ?[]const u8,

    /// The CIS scan result details' title.
    title: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .check_description = "checkDescription",
        .check_id = "checkId",
        .finding_arn = "findingArn",
        .level = "level",
        .platform = "platform",
        .remediation = "remediation",
        .scan_arn = "scanArn",
        .status = "status",
        .status_reason = "statusReason",
        .target_resource_id = "targetResourceId",
        .title = "title",
    };
};
