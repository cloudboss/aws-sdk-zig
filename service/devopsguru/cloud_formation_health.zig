const InsightHealth = @import("insight_health.zig").InsightHealth;

/// Information about the health of Amazon Web Services resources in your
/// account that are specified by
/// an Amazon Web Services CloudFormation stack.
pub const CloudFormationHealth = struct {
    /// Number of resources that DevOps Guru is monitoring in your account that are
    /// specified by an Amazon Web Services CloudFormation stack.
    analyzed_resource_count: ?i64 = null,

    /// Information about the health of the Amazon Web Services resources in your
    /// account that are
    /// specified by an Amazon Web Services CloudFormation stack, including the
    /// number of open proactive, open reactive
    /// insights, and the Mean Time to Recover (MTTR) of closed insights.
    insight: ?InsightHealth = null,

    /// The name of the CloudFormation stack.
    stack_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzed_resource_count = "AnalyzedResourceCount",
        .insight = "Insight",
        .stack_name = "StackName",
    };
};
