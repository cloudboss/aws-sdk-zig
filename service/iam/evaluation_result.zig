const aws = @import("aws");

const PolicyEvaluationDecisionType = @import("policy_evaluation_decision_type.zig").PolicyEvaluationDecisionType;
const Statement = @import("statement.zig").Statement;
const OrganizationsDecisionDetail = @import("organizations_decision_detail.zig").OrganizationsDecisionDetail;
const PermissionsBoundaryDecisionDetail = @import("permissions_boundary_decision_detail.zig").PermissionsBoundaryDecisionDetail;
const ResourceSpecificResult = @import("resource_specific_result.zig").ResourceSpecificResult;

/// Contains the results of a simulation.
///
/// This data type is used by the return parameter of `
/// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html)
/// ` and `
/// [SimulatePrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulatePrincipalPolicy.html)
/// `.
///
/// The simulator now returns a single `EvaluationResult` per action,
/// regardless of how many resource ARNs are provided. Previously, simulating
/// one action
/// against N resources returned N evaluation results, each containing the same
/// aggregate
/// decision. The top-level fields (`EvalDecision`,
/// `MatchedStatements`, `MissingContextValues`,
/// `EvalDecisionDetails`) now represent the
/// *aggregate* decision across all requested resources. The top-level
/// `EvalDecision` reflects the most restrictive decision across all resources
/// (for example, if any resource produces `explicitDeny`, the top-level
/// decision is `explicitDeny`).
///
/// To see the decision for each individual resource, use
/// `ResourceSpecificResults`. If your application parses evaluation results per
/// resource ARN, update your code to read per-resource decisions from
/// `ResourceSpecificResults` rather than from the top-level result.
pub const EvaluationResult = struct {
    /// The name of the API operation tested on the indicated resource.
    eval_action_name: []const u8,

    /// The result of the simulation.
    eval_decision: PolicyEvaluationDecisionType,

    /// Additional details about the results of the cross-account evaluation
    /// decision. This
    /// parameter is populated for only cross-account simulations. It contains a
    /// brief summary of
    /// how each policy type contributes to the final evaluation decision.
    ///
    /// In the top-level result, this map reports the most restrictive decision per
    /// policy
    /// type across all requested resources.
    ///
    /// If the simulation evaluates policies within the same account and includes a
    /// resource
    /// ARN, then the parameter is present but the response is empty. If the
    /// simulation evaluates
    /// policies within the same account and specifies all resources (`*`), then the
    /// parameter is not returned.
    ///
    /// When you make a cross-account request, Amazon Web Services evaluates the
    /// request in the trusting
    /// account and the trusted account. The request is allowed only if both
    /// evaluations return
    /// `true`. For more information about how policies are evaluated, see
    /// [Evaluating policies within a single
    /// account](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics).
    ///
    /// If an Organizations SCP included in the evaluation denies access, the
    /// simulation ends. In
    /// this case, policy evaluation does not proceed any further and this parameter
    /// is not
    /// returned.
    eval_decision_details: ?[]const aws.map.MapEntry(PolicyEvaluationDecisionType) = null,

    /// The ARN template for the simulated resource type (for example,
    /// `arn:${Partition}:s3:::${BucketName}/${KeyName}`), or `*` if no
    /// ARN format is defined for the action. This is not a specific
    /// customer-provided resource
    /// ARN. To find the decision for a specific resource, use
    /// `ResourceSpecificResults`.
    ///
    /// If you previously relied on `EvalResourceName` to identify which specific
    /// resource a result applies to, you must now use the `EvalResourceName` field
    /// within individual entries in `ResourceSpecificResults` instead.
    eval_resource_name: ?[]const u8 = null,

    /// A list of the statements in the input policies that determine the result for
    /// this
    /// scenario. Remember that even if multiple statements allow the operation on
    /// the resource, if
    /// only one statement denies that operation, then the explicit deny overrides
    /// any allow. In
    /// addition, the deny statement is the only entry included in the result.
    ///
    /// In the top-level result, this field contains the union of matched statements
    /// across all
    /// requested resources. Only statements that contributed to the reported
    /// decision are
    /// included. For per-resource matched statements, see
    /// `ResourceSpecificResults`. This field doesn't include statements from
    /// service control policies (SCPs). Only statements from identity-based and
    /// resource-based
    /// policies appear here.
    matched_statements: ?[]const Statement = null,

    /// A list of context keys that are required by the included input policies but
    /// that were
    /// not provided by one of the input parameters. This list is used when the
    /// resource in a
    /// simulation is "*", either explicitly, or when the `ResourceArns` parameter
    /// blank. If you include a list of resources, then any missing context values
    /// are instead
    /// included under the `ResourceSpecificResults` section. To discover the
    /// context
    /// keys used by a set of policies, you can call
    /// [GetContextKeysForCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForCustomPolicy.html) or [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html).
    ///
    /// In the top-level result, this field contains the deduplicated set of missing
    /// context
    /// values across all requested resources. This field doesn't include context
    /// keys referenced
    /// by service control policies (SCPs). Only context keys referenced by
    /// identity-based and
    /// resource-based policies appear here.
    missing_context_values: ?[]const []const u8 = null,

    /// A structure that details how Organizations and its service control policies
    /// affect the results of
    /// the simulation. Only applies if the simulated user's account is part of an
    /// organization.
    ///
    /// For resources that don't support organization-level evaluation, this field
    /// is omitted
    /// from the top-level result. For per-resource details, see
    /// `ResourceSpecificResults`.
    organizations_decision_detail: ?OrganizationsDecisionDetail = null,

    /// Contains information about the effect that a permissions boundary has on a
    /// policy
    /// simulation when the boundary is applied to an IAM entity.
    permissions_boundary_decision_detail: ?PermissionsBoundaryDecisionDetail = null,

    /// The individual results of the simulation of the API operation specified in
    /// EvalActionName on each resource.
    resource_specific_results: ?[]const ResourceSpecificResult = null,
};
