const PolicyEvaluationDecisionType = @import("policy_evaluation_decision_type.zig").PolicyEvaluationDecisionType;
const Statement = @import("statement.zig").Statement;
const PermissionsBoundaryDecisionDetail = @import("permissions_boundary_decision_detail.zig").PermissionsBoundaryDecisionDetail;

/// Contains the result of the simulation of a single API operation call on a
/// single
/// resource.
///
/// This data type is used by a member of the
/// [EvaluationResult](https://docs.aws.amazon.com/IAM/latest/APIReference/API_EvaluationResult.html) data
/// type.
pub const ResourceSpecificResult = struct {
    /// Additional details about the results of the evaluation decision on a single
    /// resource.
    /// This parameter is returned only for cross-account simulations. This
    /// parameter explains how
    /// each policy type contributes to the resource-specific evaluation decision.
    eval_decision_details: ?[]const u8,

    /// The result of the simulation of the simulated API operation on the resource
    /// specified in
    /// `EvalResourceName`.
    eval_resource_decision: PolicyEvaluationDecisionType,

    /// The name of the simulated resource, in Amazon Resource Name (ARN) format.
    eval_resource_name: []const u8,

    /// A list of the statements in the input policies that determine the result for
    /// this part
    /// of the simulation. Remember that even if multiple statements allow the
    /// operation on the
    /// resource, if *any* statement denies that operation, then the explicit
    /// deny overrides any allow. In addition, the deny statement is the only entry
    /// included in the
    /// result.
    matched_statements: ?[]const Statement,

    /// A list of context keys that are required by the included input policies but
    /// that were
    /// not provided by one of the input parameters. This list is used when a list
    /// of ARNs is
    /// included in the `ResourceArns` parameter instead of "*". If you do not
    /// specify
    /// individual resources, by setting `ResourceArns` to "*" or by not including
    /// the
    /// `ResourceArns` parameter, then any missing context values are instead
    /// included under the `EvaluationResults` section. To discover the context keys
    /// used by a set of policies, you can call
    /// [GetContextKeysForCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForCustomPolicy.html) or [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html).
    missing_context_values: ?[]const []const u8,

    /// Contains information about the effect that a permissions boundary has on a
    /// policy
    /// simulation when that boundary is applied to an IAM entity.
    permissions_boundary_decision_detail: ?PermissionsBoundaryDecisionDetail,
};
