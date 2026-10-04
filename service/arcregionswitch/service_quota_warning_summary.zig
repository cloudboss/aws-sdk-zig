const ServiceQuotaWarningStatus = @import("service_quota_warning_status.zig").ServiceQuotaWarningStatus;

/// A service quota warning for a plan. Region switch creates a warning when the
/// applied quota value in one Region of a plan is lower than the value for the
/// matching resource in another Region or account in the plan, or when it can't
/// complete a service quota check.
pub const ServiceQuotaWarningSummary = struct {
    /// The Amazon Web Services account ID that owns the plan that the warning
    /// applies to.
    account_id: []const u8,

    /// The ID of the support case associated with the quota increase request, if
    /// Region switch submitted one for this quota.
    case_id: ?[]const u8 = null,

    /// The time (UTC) when Region switch last checked this quota.
    last_checked_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the plan that the warning applies to.
    plan_arn: []const u8,

    /// The quota code of the quota that the warning applies to, as defined in
    /// Service Quotas.
    quota_code: ?[]const u8 = null,

    /// The name of the quota that the warning applies to, as defined in Service
    /// Quotas.
    quota_name: ?[]const u8 = null,

    /// The Amazon Web Services Region that the quota applies to.
    quota_region: []const u8,

    /// The ID of the quota increase request that Region switch submitted, if it
    /// submitted one for this quota.
    request_id: ?[]const u8 = null,

    /// The service code of the service that the quota belongs to, as defined in
    /// Service Quotas. For example, `ec2`.
    service_code: ?[]const u8 = null,

    /// The status of the service quota warning.
    status: ServiceQuotaWarningStatus,

    /// The time (UTC) when Region switch created this warning.
    warning_created_at: ?i64 = null,

    /// A message that describes the service quota warning.
    warning_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .case_id = "caseId",
        .last_checked_at = "lastCheckedAt",
        .plan_arn = "planArn",
        .quota_code = "quotaCode",
        .quota_name = "quotaName",
        .quota_region = "quotaRegion",
        .request_id = "requestId",
        .service_code = "serviceCode",
        .status = "status",
        .warning_created_at = "warningCreatedAt",
        .warning_message = "warningMessage",
    };
};
