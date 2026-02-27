const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;
const NodeStatus = @import("node_status.zig").NodeStatus;
const NodeType = @import("node_type.zig").NodeType;
const VolumeType = @import("volume_type.zig").VolumeType;

/// Container for information about nodes on the domain.
pub const DomainNodesStatus = struct {
    /// The Availability Zone of the node.
    availability_zone: ?[]const u8,

    /// The instance type information of the node.
    instance_type: ?OpenSearchPartitionInstanceType,

    /// The ID of the node.
    node_id: ?[]const u8,

    /// Indicates if the node is active or in standby.
    node_status: ?NodeStatus,

    /// Indicates whether the nodes is a data, master, or UltraWarm node.
    node_type: ?NodeType,

    /// The storage size of the node, in GiB.
    storage_size: ?[]const u8,

    /// Indicates if the node has EBS or instance storage.
    storage_type: ?[]const u8,

    /// If the nodes has EBS storage, indicates if the volume type is gp2 or gp3.
    /// Only
    /// applicable for data nodes.
    storage_volume_type: ?VolumeType,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .instance_type = "InstanceType",
        .node_id = "NodeId",
        .node_status = "NodeStatus",
        .node_type = "NodeType",
        .storage_size = "StorageSize",
        .storage_type = "StorageType",
        .storage_volume_type = "StorageVolumeType",
    };
};
