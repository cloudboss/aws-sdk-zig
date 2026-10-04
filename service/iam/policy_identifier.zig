const InlinePolicyIdentifierType = @import("inline_policy_identifier_type.zig").InlinePolicyIdentifierType;
const PolicyIdentifierPolicyType = @import("policy_identifier_policy_type.zig").PolicyIdentifierPolicyType;

/// Identifies one or more policies as a union type. Specify exactly one of
/// `PolicyType`, `PolicyArn`, or
/// `InlinePolicyIdentifier` to identify policies by their type, by Amazon
/// Resource Name (ARN), or by the name of an inline policy and the entity it is
/// attached
/// to.
pub const PolicyIdentifier = union(enum) {
    /// An inline policy identifier consisting of a policy name and the entity it is
    /// attached
    /// to. Wildcard characters (`*` and `?`) in the entity name can match
    /// multiple entities.
    inline_policy_identifier: ?InlinePolicyIdentifierType,
    /// The Amazon Resource Name (ARN) of an Amazon Web Services managed policy or a
    /// customer managed policy
    /// that is attached to an IAM user, group, or role. Wildcard characters are
    /// supported in
    /// the resource name portion of the ARN to match multiple managed policies: use
    /// at most one
    /// `*` (matches any sequence of characters, including none), and any number of
    /// `?` (each matches exactly one character).
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    policy_arn: ?[]const u8,
    /// The policy type to identify. All policies of the specified type are matched.
    policy_type: ?PolicyIdentifierPolicyType,
};
