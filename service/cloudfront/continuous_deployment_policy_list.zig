const ContinuousDeploymentPolicySummary = @import("continuous_deployment_policy_summary.zig").ContinuousDeploymentPolicySummary;

/// Contains a list of continuous deployment policies.
pub const ContinuousDeploymentPolicyList = struct {
    /// A list of continuous deployment policy items.
    items: ?[]const ContinuousDeploymentPolicySummary,

    /// The maximum number of continuous deployment policies that were specified in
    /// your request.
    max_items: i32,

    /// Indicates the next page of continuous deployment policies. To get the next
    /// page of the list, use this value in the `Marker` field of your request.
    next_marker: ?[]const u8,

    /// The total number of continuous deployment policies in your Amazon Web
    /// Services account, regardless of the `MaxItems` value.
    quantity: i32,
};
