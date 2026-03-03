const FindingAggregationAccountDetails = @import("finding_aggregation_account_details.zig").FindingAggregationAccountDetails;
const UnusedAccessTypeStatistics = @import("unused_access_type_statistics.zig").UnusedAccessTypeStatistics;

/// Provides aggregate statistics about the findings for the specified unused
/// access analyzer.
pub const UnusedAccessFindingsStatistics = struct {
    /// A list of one to ten Amazon Web Services accounts that have the most active
    /// findings for the unused access analyzer.
    top_accounts: ?[]const FindingAggregationAccountDetails = null,

    /// The total number of active findings for the unused access analyzer.
    total_active_findings: ?i32 = null,

    /// The total number of archived findings for the unused access analyzer.
    total_archived_findings: ?i32 = null,

    /// The total number of resolved findings for the unused access analyzer.
    total_resolved_findings: ?i32 = null,

    /// A list of details about the total number of findings for each type of unused
    /// access for the analyzer.
    unused_access_type_statistics: ?[]const UnusedAccessTypeStatistics = null,

    pub const json_field_names = .{
        .top_accounts = "topAccounts",
        .total_active_findings = "totalActiveFindings",
        .total_archived_findings = "totalArchivedFindings",
        .total_resolved_findings = "totalResolvedFindings",
        .unused_access_type_statistics = "unusedAccessTypeStatistics",
    };
};
