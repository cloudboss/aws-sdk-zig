const ClusterMetadata = @import("cluster_metadata.zig").ClusterMetadata;
const InstanceMetadata = @import("instance_metadata.zig").InstanceMetadata;
const InstanceGroupMetadata = @import("instance_group_metadata.zig").InstanceGroupMetadata;
const InstanceGroupScalingMetadata = @import("instance_group_scaling_metadata.zig").InstanceGroupScalingMetadata;

/// Metadata associated with a cluster event, which may include details about
/// various resource types.
pub const EventMetadata = union(enum) {
    /// Metadata specific to cluster-level events.
    cluster: ?ClusterMetadata,
    /// Metadata specific to instance-level events.
    instance: ?InstanceMetadata,
    /// Metadata specific to instance group-level events.
    instance_group: ?InstanceGroupMetadata,
    /// Metadata related to instance group scaling events.
    instance_group_scaling: ?InstanceGroupScalingMetadata,

    pub const json_field_names = .{
        .cluster = "Cluster",
        .instance = "Instance",
        .instance_group = "InstanceGroup",
        .instance_group_scaling = "InstanceGroupScaling",
    };
};
