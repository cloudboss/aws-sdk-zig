const Container = @import("container.zig").Container;
const Volume = @import("volume.zig").Volume;

/// Details about the Kubernetes workload involved in a Kubernetes finding.
pub const KubernetesWorkloadDetails = struct {
    /// Containers running as part of the Kubernetes workload.
    containers: ?[]const Container = null,

    /// Whether the host IPC flag is enabled for the pods in the workload.
    host_ipc: ?bool = null,

    /// Whether the hostNetwork flag is enabled for the pods included in the
    /// workload.
    host_network: ?bool = null,

    /// Whether the host PID flag is enabled for the pods in the workload.
    host_pid: ?bool = null,

    /// Kubernetes workload name.
    name: ?[]const u8 = null,

    /// Kubernetes namespace that the workload is part of.
    namespace: ?[]const u8 = null,

    /// The service account name that is associated with a Kubernetes workload.
    service_account_name: ?[]const u8 = null,

    /// Kubernetes workload type (e.g. Pod, Deployment, etc.).
    @"type": ?[]const u8 = null,

    /// Kubernetes workload ID.
    uid: ?[]const u8 = null,

    /// Volumes used by the Kubernetes workload.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .containers = "Containers",
        .host_ipc = "HostIPC",
        .host_network = "HostNetwork",
        .host_pid = "HostPID",
        .name = "Name",
        .namespace = "Namespace",
        .service_account_name = "ServiceAccountName",
        .@"type" = "Type",
        .uid = "Uid",
        .volumes = "Volumes",
    };
};
