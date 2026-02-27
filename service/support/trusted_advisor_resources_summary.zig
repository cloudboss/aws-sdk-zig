/// Details about Amazon Web Services resources that were analyzed in a call to
/// Trusted Advisor DescribeTrustedAdvisorCheckSummaries.
pub const TrustedAdvisorResourcesSummary = struct {
    /// The number of Amazon Web Services resources that were flagged (listed) by
    /// the Trusted Advisor check.
    resources_flagged: i64 = 0,

    /// The number of Amazon Web Services resources ignored by Trusted Advisor
    /// because information was
    /// unavailable.
    resources_ignored: i64 = 0,

    /// The number of Amazon Web Services resources that were analyzed by the
    /// Trusted Advisor check.
    resources_processed: i64 = 0,

    /// The number of Amazon Web Services resources ignored by Trusted Advisor
    /// because they were marked as
    /// suppressed by the user.
    resources_suppressed: i64 = 0,

    pub const json_field_names = .{
        .resources_flagged = "resourcesFlagged",
        .resources_ignored = "resourcesIgnored",
        .resources_processed = "resourcesProcessed",
        .resources_suppressed = "resourcesSuppressed",
    };
};
