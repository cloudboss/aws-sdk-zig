const ContributorInsightsMode = @import("contributor_insights_mode.zig").ContributorInsightsMode;
const ContributorInsightsStatus = @import("contributor_insights_status.zig").ContributorInsightsStatus;

/// Represents a Contributor Insights summary entry.
pub const ContributorInsightsSummary = struct {
    /// Indicates the current mode of CloudWatch Contributor Insights, specifying
    /// whether it
    /// tracks all access and throttled events or throttled events only for the
    /// DynamoDB
    /// table or index.
    contributor_insights_mode: ?ContributorInsightsMode,

    /// Describes the current status for contributor insights for the given table
    /// and index,
    /// if applicable.
    contributor_insights_status: ?ContributorInsightsStatus,

    /// Name of the index associated with the summary, if any.
    index_name: ?[]const u8,

    /// Name of the table associated with the summary.
    table_name: ?[]const u8,
};
