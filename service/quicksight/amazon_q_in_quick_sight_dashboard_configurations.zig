const ExecutiveSummaryConfigurations = @import("executive_summary_configurations.zig").ExecutiveSummaryConfigurations;

/// A collection of Amazon Q feature configurations in an embedded Quick Sight
/// dashboard.
pub const AmazonQInQuickSightDashboardConfigurations = struct {
    /// A generated executive summary of an embedded Quick Sight dashboard.
    executive_summary: ?ExecutiveSummaryConfigurations = null,

    pub const json_field_names = .{
        .executive_summary = "ExecutiveSummary",
    };
};
