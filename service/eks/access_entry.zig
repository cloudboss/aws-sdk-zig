const aws = @import("aws");

/// An access entry allows an IAM principal (user or role) to access your
/// cluster.
/// Access entries can replace the need to maintain the `aws-auth`
/// `ConfigMap` for authentication. For more information about access entries,
/// see [Access
/// entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html) in the *Amazon EKS User Guide*.
pub const AccessEntry = struct {
    /// The ARN of the access entry.
    access_entry_arn: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: ?[]const u8 = null,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64 = null,

    /// A `name` that you've specified in a Kubernetes `RoleBinding` or
    /// `ClusterRoleBinding` object so that Kubernetes authorizes the
    /// `principalARN` access to cluster objects.
    kubernetes_groups: ?[]const []const u8 = null,

    /// The Unix epoch timestamp for the last modification to the object.
    modified_at: ?i64 = null,

    /// The ARN of the IAM principal for the access entry. If you ever delete the
    /// IAM
    /// principal with this ARN, the access entry isn't automatically deleted. We
    /// recommend
    /// that you delete the access entry with an ARN for an IAM principal that you
    /// delete.
    /// If you don't delete the access entry and ever recreate the IAM principal,
    /// even if it
    /// has the same ARN, the access entry won't work. This is because even though
    /// the ARN
    /// is the same for the recreated IAM principal, the `roleID` or
    /// `userID` (you can see this with the Security Token Service
    /// `GetCallerIdentity` API) is different for the recreated IAM principal
    /// than it was for the original IAM principal. Even though you don't see the
    /// IAM
    /// principal's `roleID` or `userID` for an access entry, Amazon EKS stores
    /// it with the access entry.
    principal_arn: ?[]const u8 = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the access entry.
    @"type": ?[]const u8 = null,

    /// The `name` of a user that can authenticate to your cluster.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_entry_arn = "accessEntryArn",
        .cluster_name = "clusterName",
        .created_at = "createdAt",
        .kubernetes_groups = "kubernetesGroups",
        .modified_at = "modifiedAt",
        .principal_arn = "principalArn",
        .tags = "tags",
        .@"type" = "type",
        .username = "username",
    };
};
