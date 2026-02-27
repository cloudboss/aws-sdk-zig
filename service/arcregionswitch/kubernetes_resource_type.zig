/// Defines the type of Kubernetes resource to scale in an Amazon EKS cluster.
pub const KubernetesResourceType = struct {
    /// The API version type for the Kubernetes resource.
    api_version: []const u8,

    /// The kind for the Kubernetes resource.
    kind: []const u8,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .kind = "kind",
    };
};
