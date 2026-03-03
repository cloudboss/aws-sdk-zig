/// Namespace inputs for the system job.
pub const SecureNamespaceInfo = struct {
    /// The ID of the Amazon EKS cluster where Amazon EMR on EKS jobs run.
    cluster_id: ?[]const u8 = null,

    /// The namespace of the Amazon EKS cluster where the system jobs run.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_id = "clusterId",
        .namespace = "namespace",
    };
};
