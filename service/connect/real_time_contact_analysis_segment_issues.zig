const RealTimeContactAnalysisIssueDetected = @import("real_time_contact_analysis_issue_detected.zig").RealTimeContactAnalysisIssueDetected;

/// Segment type containing a list of detected issues.
pub const RealTimeContactAnalysisSegmentIssues = struct {
    /// List of the issues detected.
    issues_detected: []const RealTimeContactAnalysisIssueDetected,

    pub const json_field_names = .{
        .issues_detected = "IssuesDetected",
    };
};
