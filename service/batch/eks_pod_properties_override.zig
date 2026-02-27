const EksContainerOverride = @import("eks_container_override.zig").EksContainerOverride;
const EksMetadata = @import("eks_metadata.zig").EksMetadata;

/// An object that contains overrides for the Kubernetes pod properties of a
/// job.
pub const EksPodPropertiesOverride = struct {
    /// The overrides for the container that's used on the Amazon EKS pod.
    containers: ?[]const EksContainerOverride,

    /// The overrides for the `initContainers` defined in the Amazon EKS pod. These
    /// containers run before
    /// application containers, always run to completion, and must complete
    /// successfully before the next
    /// container starts. These containers are registered with the Amazon EKS
    /// Connector agent and persists the
    /// registration information in the Kubernetes backend data store. For more
    /// information, see [Init
    /// Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) in the *Kubernetes documentation*.
    init_containers: ?[]const EksContainerOverride,

    /// Metadata about the overrides for the container that's used on the Amazon EKS
    /// pod.
    metadata: ?EksMetadata,

    pub const json_field_names = .{
        .containers = "containers",
        .init_containers = "initContainers",
        .metadata = "metadata",
    };
};
