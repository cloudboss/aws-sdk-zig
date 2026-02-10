/// Contains information about an IAM policy, including the policy document.
///
/// This data type is used as a response element in the
/// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operation.
pub const PolicyDetail = struct {
    /// The policy document.
    policy_document: ?[]const u8,

    /// The name of the policy.
    policy_name: ?[]const u8,
};
