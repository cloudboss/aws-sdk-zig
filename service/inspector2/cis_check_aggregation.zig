const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;
const StatusCounts = @import("status_counts.zig").StatusCounts;

/// A CIS check.
pub const CisCheckAggregation = struct {
    /// The account ID for the CIS check.
    account_id: ?[]const u8 = null,

    /// The description for the CIS check.
    check_description: ?[]const u8 = null,

    /// The check ID for the CIS check.
    check_id: ?[]const u8 = null,

    /// The CIS check level.
    level: ?CisSecurityLevel = null,

    /// The CIS check platform.
    platform: ?[]const u8 = null,

    /// The scan ARN for the CIS check scan ARN.
    scan_arn: []const u8,

    /// The CIS check status counts.
    status_counts: ?StatusCounts = null,

    /// The CIS check title.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .check_description = "checkDescription",
        .check_id = "checkId",
        .level = "level",
        .platform = "platform",
        .scan_arn = "scanArn",
        .status_counts = "statusCounts",
        .title = "title",
    };
};
