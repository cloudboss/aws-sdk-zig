const aws = @import("aws");

const ComplianceViolator = @import("compliance_violator.zig").ComplianceViolator;

/// Describes
/// the noncompliant resources in a member account for a specific Firewall
/// Manager policy. A maximum of 100 entries are displayed. If more than 100
/// resources are
/// noncompliant, `EvaluationLimitExceeded` is set to `True`.
pub const PolicyComplianceDetail = struct {
    /// Indicates if over 100 resources are noncompliant with the Firewall Manager
    /// policy.
    evaluation_limit_exceeded: bool = false,

    /// A timestamp that indicates when the returned information should be
    /// considered out of
    /// date.
    expired_at: ?i64 = null,

    /// Details about problems with dependent services, such as WAF or Config,
    /// and the error message received that indicates the problem with the service.
    issue_info_map: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services account ID.
    member_account: ?[]const u8 = null,

    /// The ID of the Firewall Manager policy.
    policy_id: ?[]const u8 = null,

    /// The Amazon Web Services account that created the Firewall Manager policy.
    policy_owner: ?[]const u8 = null,

    /// An array of resources that aren't protected by the WAF or Shield Advanced
    /// policy or
    /// that aren't in compliance with the security group policy.
    violators: ?[]const ComplianceViolator = null,

    pub const json_field_names = .{
        .evaluation_limit_exceeded = "EvaluationLimitExceeded",
        .expired_at = "ExpiredAt",
        .issue_info_map = "IssueInfoMap",
        .member_account = "MemberAccount",
        .policy_id = "PolicyId",
        .policy_owner = "PolicyOwner",
        .violators = "Violators",
    };
};
