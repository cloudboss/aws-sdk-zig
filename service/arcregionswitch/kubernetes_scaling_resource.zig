/// Defines a Kubernetes resource to scale in an Amazon EKS cluster.
pub const KubernetesScalingResource = struct {
    /// The hpaname for the Kubernetes resource.
    hpa_name: ?[]const u8 = null,

    /// The name for the Kubernetes resource.
    name: []const u8,

    /// The namespace for the Kubernetes resource.
    namespace: []const u8,

    pub const json_field_names = .{
        .hpa_name = "hpaName",
        .name = "name",
        .namespace = "namespace",
    };
};
