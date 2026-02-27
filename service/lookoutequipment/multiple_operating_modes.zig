const StatisticalIssueStatus = @import("statistical_issue_status.zig").StatisticalIssueStatus;

/// Entity that comprises information on operating modes in data.
pub const MultipleOperatingModes = struct {
    /// Indicates whether there is a potential data issue related to having multiple
    /// operating
    /// modes.
    status: StatisticalIssueStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
