/// The summarized description of the association.
///
/// Each summary is simplified by removing these fields compared to the full [
/// `PodIdentityAssociation`
/// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_PodIdentityAssociation.html):
///
/// * The IAM role: `roleArn`
///
/// * The timestamp that the association was created at: `createdAt`
///
/// * The most recent timestamp that the association was modified at:.
///   `modifiedAt`
///
/// * The tags on the association: `tags`
pub const PodIdentityAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the association.
    association_arn: ?[]const u8 = null,

    /// The ID of the association.
    association_id: ?[]const u8 = null,

    /// The name of the cluster that the association is in.
    cluster_name: ?[]const u8 = null,

    /// The name of the Kubernetes namespace inside the cluster to create the
    /// association in. The
    /// service account and the Pods that use the service account must be in this
    /// namespace.
    namespace: ?[]const u8 = null,

    /// If defined, the association is owned by an Amazon EKS add-on.
    owner_arn: ?[]const u8 = null,

    /// The name of the Kubernetes service account inside the cluster to associate
    /// the IAM
    /// credentials with.
    service_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_arn = "associationArn",
        .association_id = "associationId",
        .cluster_name = "clusterName",
        .namespace = "namespace",
        .owner_arn = "ownerArn",
        .service_account = "serviceAccount",
    };
};
