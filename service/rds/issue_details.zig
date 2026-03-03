const PerformanceIssueDetails = @import("performance_issue_details.zig").PerformanceIssueDetails;

/// The details of an issue with your DB instances, DB clusters, and DB
/// parameter groups.
pub const IssueDetails = struct {
    /// A detailed description of the issue when the recommendation category is
    /// `performance`.
    performance_issue_details: ?PerformanceIssueDetails = null,
};
