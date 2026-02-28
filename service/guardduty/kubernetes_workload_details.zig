const Container = @import("container.zig").Container;
const Volume = @import("volume.zig").Volume;

/// Details about the Kubernetes workload involved in a Kubernetes finding.
pub const KubernetesWorkloadDetails = struct {
    /// Containers running as part of the Kubernetes workload.
    containers: ?[]const Container,

    /// Whether the host IPC flag is enabled for the pods in the workload.
    host_ipc: ?bool,

    /// Whether the hostNetwork flag is enabled for the pods included in the
    /// workload.
    host_network: ?bool,

    /// Whether the host PID flag is enabled for the pods in the workload.
    host_pid: ?bool,

    /// Kubernetes workload name.
    name: ?[]const u8,

    /// Kubernetes namespace that the workload is part of.
    namespace: ?[]const u8,

    /// The service account name that is associated with a Kubernetes workload.
    service_account_name: ?[]const u8,

    /// Kubernetes workload type (e.g. Pod, Deployment, etc.).
    @"type": ?[]const u8,

    /// Kubernetes workload ID.
    uid: ?[]const u8,

    /// Volumes used by the Kubernetes workload.
    volumes: ?[]const Volume,

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
