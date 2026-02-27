const aws = @import("aws");

const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;

/// Indicates whether the account is compliant with the specified policy. An
/// account is
/// considered noncompliant if it includes resources that are not protected by
/// the policy, for
/// WAF and Shield Advanced policies, or that are noncompliant with the policy,
/// for security group
/// policies.
pub const PolicyComplianceStatus = struct {
    /// An array of `EvaluationResult` objects.
    evaluation_results: ?[]const EvaluationResult,

    /// Details about problems with dependent services, such as WAF or Config,
    /// and the error message received that indicates the problem with the service.
    issue_info_map: ?[]const aws.map.StringMapEntry,

    /// Timestamp of the last update to the `EvaluationResult` objects.
    last_updated: ?i64,

    /// The member account ID.
    member_account: ?[]const u8,

    /// The ID of the Firewall Manager policy.
    policy_id: ?[]const u8,

    /// The name of the Firewall Manager policy.
    policy_name: ?[]const u8,

    /// The Amazon Web Services account that created the Firewall Manager policy.
    policy_owner: ?[]const u8,

    pub const json_field_names = .{
        .evaluation_results = "EvaluationResults",
        .issue_info_map = "IssueInfoMap",
        .last_updated = "LastUpdated",
        .member_account = "MemberAccount",
        .policy_id = "PolicyId",
        .policy_name = "PolicyName",
        .policy_owner = "PolicyOwner",
    };
};
