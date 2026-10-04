const ClusterMetadata = @import("cluster_metadata.zig").ClusterMetadata;
const DatabaseConfigurationMetadata = @import("database_configuration_metadata.zig").DatabaseConfigurationMetadata;
const InstanceMetadata = @import("instance_metadata.zig").InstanceMetadata;
const InstanceGroupMetadata = @import("instance_group_metadata.zig").InstanceGroupMetadata;
const InstanceGroupScalingMetadata = @import("instance_group_scaling_metadata.zig").InstanceGroupScalingMetadata;
const SlurmHealthMetadata = @import("slurm_health_metadata.zig").SlurmHealthMetadata;

/// Metadata associated with a cluster event, which may include details about
/// various resource types.
pub const EventMetadata = union(enum) {
    /// Metadata specific to cluster-level events.
    cluster: ?ClusterMetadata,
    /// Metadata specific to events about the external Slurm accounting database of
    /// the cluster.
    database_configuration: ?DatabaseConfigurationMetadata,
    /// Metadata specific to instance-level events.
    instance: ?InstanceMetadata,
    /// Metadata specific to instance group-level events.
    instance_group: ?InstanceGroupMetadata,
    /// Metadata related to instance group scaling events.
    instance_group_scaling: ?InstanceGroupScalingMetadata,
    /// Metadata specific to events about the health of the Slurm components on the
    /// controller node of the cluster.
    slurm_health: ?SlurmHealthMetadata,

    pub const json_field_names = .{
        .cluster = "Cluster",
        .database_configuration = "DatabaseConfiguration",
        .instance = "Instance",
        .instance_group = "InstanceGroup",
        .instance_group_scaling = "InstanceGroupScaling",
        .slurm_health = "SlurmHealth",
    };
};
