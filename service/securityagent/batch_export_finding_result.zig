const LinkedIssue = @import("linked_issue.zig").LinkedIssue;

/// A finding whose issue was created.
pub const BatchExportFindingResult = struct {
    /// The identifier of the finding this result corresponds to.
    finding_id: []const u8,

    /// The issue that was created for the finding.
    linked_issue: LinkedIssue,

    pub const json_field_names = .{
        .finding_id = "findingId",
        .linked_issue = "linkedIssue",
    };
};
