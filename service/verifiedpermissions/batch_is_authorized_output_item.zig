const Decision = @import("decision.zig").Decision;
const DeterminingPolicyItem = @import("determining_policy_item.zig").DeterminingPolicyItem;
const EvaluationErrorItem = @import("evaluation_error_item.zig").EvaluationErrorItem;
const BatchIsAuthorizedInputItem = @import("batch_is_authorized_input_item.zig").BatchIsAuthorizedInputItem;

/// The decision, based on policy evaluation, from an individual authorization
/// request in a `BatchIsAuthorized` API request.
pub const BatchIsAuthorizedOutputItem = struct {
    /// An authorization decision that indicates if the authorization request should
    /// be allowed or denied.
    decision: Decision,

    /// The list of determining policies used to make the authorization decision.
    /// For example, if there are two matching policies, where one is a forbid and
    /// the other is a permit, then the forbid policy will be the determining
    /// policy. In the case of multiple matching permit policies then there would be
    /// multiple determining policies. In the case that no policies match, and hence
    /// the response is DENY, there would be no determining policies.
    determining_policies: []const DeterminingPolicyItem,

    /// Errors that occurred while making an authorization decision. For example, a
    /// policy might reference an entity or attribute that doesn't exist in the
    /// request.
    errors: []const EvaluationErrorItem,

    /// The authorization request that initiated the decision.
    request: BatchIsAuthorizedInputItem,

    pub const json_field_names = .{
        .decision = "decision",
        .determining_policies = "determiningPolicies",
        .errors = "errors",
        .request = "request",
    };
};
