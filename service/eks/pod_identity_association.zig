const aws = @import("aws");

/// Amazon EKS Pod Identity associations provide the ability to manage
/// credentials for your applications, similar to the way that Amazon EC2
/// instance profiles provide credentials to Amazon EC2 instances.
pub const PodIdentityAssociation = struct {
    /// The Amazon Resource Name (ARN) of the association.
    association_arn: ?[]const u8,

    /// The ID of the association.
    association_id: ?[]const u8,

    /// The name of the cluster that the association is in.
    cluster_name: ?[]const u8,

    /// The timestamp that the association was created at.
    created_at: ?i64,

    /// The state of the automatic sessions tags. The value of *true*
    /// disables these tags.
    ///
    /// EKS Pod Identity adds a pre-defined set of session tags when it assumes the
    /// role. You
    /// can use these tags to author a single role that can work across resources by
    /// allowing
    /// access to Amazon Web Services resources based on matching tags. By default,
    /// EKS Pod Identity attaches
    /// six tags, including tags for cluster name, namespace, and service account
    /// name. For the
    /// list of tags added by EKS Pod Identity, see [List of session tags
    /// added by EKS Pod
    /// Identity](https://docs.aws.amazon.com/eks/latest/userguide/pod-id-abac.html#pod-id-abac-tags) in the *Amazon EKS User Guide*.
    disable_session_tags: ?bool,

    /// The unique identifier for this EKS Pod Identity association for a target IAM
    /// role. You put this value
    /// in the trust policy of the target role, in a `Condition` to match the
    /// `sts.ExternalId`. This ensures that the target role can only be assumed
    /// by this association. This prevents the *confused deputy problem*. For
    /// more information about the confused deputy problem, see [The confused deputy
    /// problem](https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html) in the *IAM User Guide*.
    ///
    /// If you want to use the same target role with multiple associations or
    /// other roles, use independent statements in the trust policy to allow
    /// `sts:AssumeRole` access from each role.
    external_id: ?[]const u8,

    /// The most recent timestamp that the association was modified at.
    modified_at: ?i64,

    /// The name of the Kubernetes namespace inside the cluster to create the
    /// association in. The
    /// service account and the Pods that use the service account must be in this
    /// namespace.
    namespace: ?[]const u8,

    /// If defined, the EKS Pod Identity association is owned by an Amazon EKS
    /// add-on.
    owner_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role to associate with the service
    /// account. The EKS Pod Identity
    /// agent manages credentials to assume this role for applications in the
    /// containers in the
    /// Pods that use this service account.
    role_arn: ?[]const u8,

    /// The name of the Kubernetes service account inside the cluster to associate
    /// the IAM
    /// credentials with.
    service_account: ?[]const u8,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource – 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length – 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length – 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with
    /// this prefix do not count against your tags per resource limit.
    tags: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the target IAM role to associate with the
    /// service account. This
    /// role is assumed by using the EKS Pod Identity association role, then the
    /// credentials for this
    /// role are injected into the Pod.
    target_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .association_arn = "associationArn",
        .association_id = "associationId",
        .cluster_name = "clusterName",
        .created_at = "createdAt",
        .disable_session_tags = "disableSessionTags",
        .external_id = "externalId",
        .modified_at = "modifiedAt",
        .namespace = "namespace",
        .owner_arn = "ownerArn",
        .role_arn = "roleArn",
        .service_account = "serviceAccount",
        .tags = "tags",
        .target_role_arn = "targetRoleArn",
    };
};
