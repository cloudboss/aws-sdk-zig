const TrustedAdvisorCategorySpecificSummary = @import("trusted_advisor_category_specific_summary.zig").TrustedAdvisorCategorySpecificSummary;
const TrustedAdvisorResourceDetail = @import("trusted_advisor_resource_detail.zig").TrustedAdvisorResourceDetail;
const TrustedAdvisorResourcesSummary = @import("trusted_advisor_resources_summary.zig").TrustedAdvisorResourcesSummary;

/// The results of a Trusted Advisor check returned by
/// DescribeTrustedAdvisorCheckResult.
pub const TrustedAdvisorCheckResult = struct {
    /// Summary information that relates to the category of the check. Cost
    /// Optimizing is the
    /// only category that is currently supported.
    category_specific_summary: TrustedAdvisorCategorySpecificSummary,

    /// The unique identifier for the Trusted Advisor check.
    check_id: []const u8,

    /// The details about each resource listed in the check result.
    flagged_resources: []const TrustedAdvisorResourceDetail,

    resources_summary: TrustedAdvisorResourcesSummary,

    /// The alert status of the check: "ok" (green), "warning" (yellow), "error"
    /// (red), or
    /// "not_available".
    status: []const u8,

    /// The time of the last refresh of the check.
    timestamp: []const u8,

    pub const json_field_names = .{
        .category_specific_summary = "categorySpecificSummary",
        .check_id = "checkId",
        .flagged_resources = "flaggedResources",
        .resources_summary = "resourcesSummary",
        .status = "status",
        .timestamp = "timestamp",
    };
};
