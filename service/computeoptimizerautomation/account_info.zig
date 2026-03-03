const OrganizationRuleMode = @import("organization_rule_mode.zig").OrganizationRuleMode;
const EnrollmentStatus = @import("enrollment_status.zig").EnrollmentStatus;

/// Contains information about an Amazon Web Services account's enrollment and
/// association status with Compute Optimizer Automation.
pub const AccountInfo = struct {
    /// The ID of the Amazon Web Services account.
    account_id: []const u8,

    /// The timestamp when the account's Automation enrollment status was last
    /// updated.
    last_updated_timestamp: i64,

    /// Specifies whether the management account can create Automation rules that
    /// implement optimization actions for this account.
    organization_rule_mode: OrganizationRuleMode,

    /// The enrollment status of the account: Active, Inactive, Pending, or Failed.
    status: EnrollmentStatus,

    /// The reason for the current Automation enrollment status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .organization_rule_mode = "organizationRuleMode",
        .status = "status",
        .status_reason = "statusReason",
    };
};
