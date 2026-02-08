/// Identifiers for the federated user that is associated with the credentials.
pub const FederatedUser = struct {
    /// The ARN that specifies the federated user that is associated with the
    /// credentials. For
    /// more information about ARNs and how to use them in policies, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the *IAM User Guide*.
    arn: []const u8,

    /// The string that identifies the federated user associated with the
    /// credentials, similar
    /// to the unique ID of an IAM user.
    federated_user_id: []const u8,
};
