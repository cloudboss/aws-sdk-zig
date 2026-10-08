const aws = @import("aws");

const EvaluatedEffect = @import("evaluated_effect.zig").EvaluatedEffect;
const MatchedPolicy = @import("matched_policy.zig").MatchedPolicy;

/// Represents an individual evaluation for a single action and resource pair.
/// This includes the context, the resulting effect, and any policies that
/// matched.
pub const Evaluation = struct {
    /// The action evaluated for this request (for example, `iam:PassRole`).
    action: []const u8,

    /// The context keys and values specific to this evaluation. These are applied
    /// on top of the request context.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The result of the evaluation. Valid values:
    ///
    /// * `ALLOW` - The action was allowed.
    /// * `EXPLICIT_DENY` - The action was explicitly denied by a policy.
    /// * `IMPLICIT_DENY` - The action was denied because no policy allowed it.
    evaluated_effect: ?EvaluatedEffect = null,

    /// The policies that matched during evaluation of this action and resource. An
    /// implicit denial produces no matched policies.
    matched_policies: ?[]const MatchedPolicy = null,

    /// The resource that the action targeted. This is typically a resource ARN, but
    /// can be a wildcard ARN that matches multiple resources, or empty for actions
    /// that are not resource-specific.
    resource: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .context = "context",
        .evaluated_effect = "evaluatedEffect",
        .matched_policies = "matchedPolicies",
        .resource = "resource",
    };
};
