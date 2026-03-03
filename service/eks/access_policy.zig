/// An access policy includes permissions that allow Amazon EKS to authorize an
/// IAM principal to work with Kubernetes objects on your cluster. The policies
/// are
/// managed by Amazon EKS, but they're not IAM policies. You can't view the
/// permissions in the
/// policies using the API. The permissions for many of the policies are similar
/// to the
/// Kubernetes `cluster-admin`, `admin`, `edit`, and
/// `view` cluster roles. For more information about these cluster roles, see
/// [User-facing
/// roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) in the Kubernetes documentation. To view the contents of the
/// policies, see [Access
/// policy
/// permissions](https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html#access-policy-permissions) in the *Amazon EKS User Guide*.
pub const AccessPolicy = struct {
    /// The ARN of the access policy.
    arn: ?[]const u8 = null,

    /// The name of the access policy.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
