/// Meta data about Kubernetes resources.
pub const KubernetesMetadata = struct {
    /// The name of the pod for a local resource.
    local_pod_name: ?[]const u8 = null,

    /// The namespace of the pod for a local resource.
    local_pod_namespace: ?[]const u8 = null,

    /// The service name for a local resource.
    local_service_name: ?[]const u8 = null,

    /// The name of the pod for a remote resource.
    remote_pod_name: ?[]const u8 = null,

    /// The namespace of the pod for a remote resource.
    remote_pod_namespace: ?[]const u8 = null,

    /// The service name for a remote resource.
    remote_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .local_pod_name = "localPodName",
        .local_pod_namespace = "localPodNamespace",
        .local_service_name = "localServiceName",
        .remote_pod_name = "remotePodName",
        .remote_pod_namespace = "remotePodNamespace",
        .remote_service_name = "remoteServiceName",
    };
};
