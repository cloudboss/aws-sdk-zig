const aws = @import("aws");

const ContainerProvider = @import("container_provider.zig").ContainerProvider;
const SchedulerConfiguration = @import("scheduler_configuration.zig").SchedulerConfiguration;
const SchedulerStatus = @import("scheduler_status.zig").SchedulerStatus;
const VirtualClusterState = @import("virtual_cluster_state.zig").VirtualClusterState;

/// This entity describes a virtual cluster. A virtual cluster is a Kubernetes
/// namespace
/// that Amazon EMR is registered with. Amazon EMR uses virtual clusters to run
/// jobs and host endpoints. Multiple virtual clusters can be backed by the same
/// physical
/// cluster. However, each virtual cluster maps to one namespace on an Amazon
/// EKS
/// cluster. Virtual clusters do not create any active resources that contribute
/// to your bill
/// or that require lifecycle management outside the service.
pub const VirtualCluster = struct {
    /// The ARN of the virtual cluster.
    arn: ?[]const u8 = null,

    /// The container provider of the virtual cluster.
    container_provider: ?ContainerProvider = null,

    /// The date and time when the virtual cluster is created.
    created_at: ?i64 = null,

    /// The ID of the virtual cluster.
    id: ?[]const u8 = null,

    /// The name of the virtual cluster.
    name: ?[]const u8 = null,

    /// The scheduler configuration (concurrency and queue limits) applied to the
    /// virtual
    /// cluster. The service does not return this field when no scheduler limits are
    /// configured.
    scheduler_configuration: ?SchedulerConfiguration = null,

    /// The current in-queue and concurrent job-run counts for the virtual cluster.
    scheduler_status: ?SchedulerStatus = null,

    /// The ID of the security configuration.
    security_configuration_id: ?[]const u8 = null,

    /// Specifies whether the virtual cluster has session support enabled.
    session_enabled: ?bool = null,

    /// The state of the virtual cluster.
    state: ?VirtualClusterState = null,

    /// The assigned tags of the virtual cluster.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .container_provider = "containerProvider",
        .created_at = "createdAt",
        .id = "id",
        .name = "name",
        .scheduler_configuration = "schedulerConfiguration",
        .scheduler_status = "schedulerStatus",
        .security_configuration_id = "securityConfigurationId",
        .session_enabled = "sessionEnabled",
        .state = "state",
        .tags = "tags",
    };
};
