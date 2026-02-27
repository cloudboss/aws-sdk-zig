/// A type of EKS Pod Identity association owned by an Amazon EKS add-on.
///
/// Each association maps a role to a service account in a namespace in
/// the cluster.
///
/// For more information, see [Attach an IAM Role to an Amazon EKS add-on
/// using EKS Pod
/// Identity](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-iam.html)
/// in the *Amazon EKS User Guide*.
pub const AddonPodIdentityAssociations = struct {
    /// The ARN of an IAM Role.
    role_arn: []const u8,

    /// The name of a Kubernetes Service Account.
    service_account: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .service_account = "serviceAccount",
    };
};
