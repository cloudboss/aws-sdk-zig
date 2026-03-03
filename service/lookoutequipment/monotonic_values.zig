const Monotonicity = @import("monotonicity.zig").Monotonicity;
const StatisticalIssueStatus = @import("statistical_issue_status.zig").StatisticalIssueStatus;

/// Entity that comprises information on monotonic values in the data.
pub const MonotonicValues = struct {
    /// Indicates the monotonicity of values. Can be INCREASING, DECREASING, or
    /// STATIC.
    monotonicity: ?Monotonicity = null,

    /// Indicates whether there is a potential data issue related to having
    /// monotonic values.
    status: StatisticalIssueStatus,

    pub const json_field_names = .{
        .monotonicity = "Monotonicity",
        .status = "Status",
    };
};
