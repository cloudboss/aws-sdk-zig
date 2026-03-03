const aws = @import("aws");

const DataLocationConstraint = @import("data_location_constraint.zig").DataLocationConstraint;
const EstimatedCostTier = @import("estimated_cost_tier.zig").EstimatedCostTier;
const FailurePolicy = @import("failure_policy.zig").FailurePolicy;
const ResiliencyPolicyTier = @import("resiliency_policy_tier.zig").ResiliencyPolicyTier;

/// Defines a resiliency policy.
///
/// Resilience Hub allows you to provide a value of zero for `rtoInSecs`
/// and `rpoInSecs` of your resiliency policy. But, while assessing your
/// application,
/// the lowest possible assessment result is near zero. Hence, if you provide
/// value zero for
/// `rtoInSecs` and `rpoInSecs`, the estimated workload RTO and
/// estimated workload RPO result will be near zero and the **Compliance
/// status** for your application will be set to **Policy
/// breached**.
pub const ResiliencyPolicy = struct {
    /// Date and time when the resiliency policy was created.
    creation_time: ?i64 = null,

    /// Specifies a high-level geographical location constraint for where your
    /// resilience policy
    /// data can be stored.
    data_location_constraint: ?DataLocationConstraint = null,

    /// Specifies the estimated cost tier of the resiliency policy.
    estimated_cost_tier: ?EstimatedCostTier = null,

    /// The resiliency policy.
    policy: ?[]const aws.map.MapEntry(FailurePolicy) = null,

    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: ?[]const u8 = null,

    /// Description of the resiliency policy.
    policy_description: ?[]const u8 = null,

    /// The name of the policy
    policy_name: ?[]const u8 = null,

    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The tier for this resiliency policy, ranging from the highest severity
    /// (`MissionCritical`) to lowest (`NonCritical`).
    tier: ?ResiliencyPolicyTier = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .data_location_constraint = "dataLocationConstraint",
        .estimated_cost_tier = "estimatedCostTier",
        .policy = "policy",
        .policy_arn = "policyArn",
        .policy_description = "policyDescription",
        .policy_name = "policyName",
        .tags = "tags",
        .tier = "tier",
    };
};
