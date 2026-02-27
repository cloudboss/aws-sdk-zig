pub const StatisticalIssueStatus = enum {
    potential_issue_detected,
    no_issue_detected,

    pub const json_field_names = .{
        .potential_issue_detected = "POTENTIAL_ISSUE_DETECTED",
        .no_issue_detected = "NO_ISSUE_DETECTED",
    };
};
