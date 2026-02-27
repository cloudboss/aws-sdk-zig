const TrustedAdvisorCategorySpecificSummary = @import("trusted_advisor_category_specific_summary.zig").TrustedAdvisorCategorySpecificSummary;
const TrustedAdvisorResourcesSummary = @import("trusted_advisor_resources_summary.zig").TrustedAdvisorResourcesSummary;

/// A summary of a Trusted Advisor check result, including the alert status,
/// last refresh, and
/// number of resources examined.
pub const TrustedAdvisorCheckSummary = struct {
    /// Summary information that relates to the category of the check. Cost
    /// Optimizing is the
    /// only category that is currently supported.
    category_specific_summary: TrustedAdvisorCategorySpecificSummary,

    /// The unique identifier for the Trusted Advisor check.
    check_id: []const u8,

    /// Specifies whether the Trusted Advisor check has flagged resources.
    has_flagged_resources: bool = false,

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
        .has_flagged_resources = "hasFlaggedResources",
        .resources_summary = "resourcesSummary",
        .status = "status",
        .timestamp = "timestamp",
    };
};
