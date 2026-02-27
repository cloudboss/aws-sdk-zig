const CustomerManagedPolicyReference = @import("customer_managed_policy_reference.zig").CustomerManagedPolicyReference;

/// Specifies the configuration of the Amazon Web Services managed or customer
/// managed policy that you want to set as a permissions boundary. Specify
/// either `CustomerManagedPolicyReference` to use the name and path of a
/// customer managed policy, or `ManagedPolicyArn` to use the ARN of an Amazon
/// Web Services managed policy. A permissions boundary represents the maximum
/// permissions that any policy can grant your role. For more information, see
/// [Permissions boundaries for IAM
/// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
///
/// Policies used as permissions boundaries don't provide permissions. You must
/// also attach an IAM policy to the role. To learn how the effective
/// permissions for a role are evaluated, see [IAM JSON policy evaluation
/// logic](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html) in the *IAM User Guide*.
pub const PermissionsBoundary = struct {
    /// Specifies the name and path of a customer managed policy. You must have an
    /// IAM policy that matches the name and path in each Amazon Web Services
    /// account where you want to deploy your permission set.
    customer_managed_policy_reference: ?CustomerManagedPolicyReference,

    /// The Amazon Web Services managed policy ARN that you want to attach to a
    /// permission set as a permissions boundary.
    managed_policy_arn: ?[]const u8,

    pub const json_field_names = .{
        .customer_managed_policy_reference = "CustomerManagedPolicyReference",
        .managed_policy_arn = "ManagedPolicyArn",
    };
};
