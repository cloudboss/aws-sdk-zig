const PolicyType = @import("policy_type.zig").PolicyType;
const Scope = @import("scope.zig").Scope;

/// A structure that contains information about one CloudWatch Logs account
/// policy.
pub const AccountPolicy = struct {
    /// The Amazon Web Services account ID that the policy applies to.
    account_id: ?[]const u8,

    /// The date and time that this policy was most recently updated.
    last_updated_time: ?i64,

    /// The policy document for this account policy.
    ///
    /// The JSON specified in `policyDocument` can be up to 30,720 characters.
    policy_document: ?[]const u8,

    /// The name of the account policy.
    policy_name: ?[]const u8,

    /// The type of policy for this account policy.
    policy_type: ?PolicyType,

    /// The scope of the account policy.
    scope: ?Scope,

    /// The log group selection criteria that is used for this policy.
    selection_criteria: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .last_updated_time = "lastUpdatedTime",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .policy_type = "policyType",
        .scope = "scope",
        .selection_criteria = "selectionCriteria",
    };
};
