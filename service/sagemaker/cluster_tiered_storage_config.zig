const ClusterConfigMode = @import("cluster_config_mode.zig").ClusterConfigMode;

/// Defines the configuration for managed tier checkpointing in a HyperPod
/// cluster. Managed tier checkpointing uses multiple storage tiers, including
/// cluster CPU memory, to provide faster checkpoint operations and improved
/// fault tolerance for large-scale model training. The system automatically
/// saves checkpoints at high frequency to memory and periodically persists them
/// to durable storage, like Amazon S3.
pub const ClusterTieredStorageConfig = struct {
    /// The percentage (int) of cluster memory to allocate for checkpointing.
    instance_memory_allocation_percentage: ?i32,

    /// Specifies whether managed tier checkpointing is enabled or disabled for the
    /// HyperPod cluster. When set to `Enable`, the system installs a memory
    /// management daemon that provides disaggregated memory as a service for
    /// checkpoint storage. When set to `Disable`, the feature is turned off and the
    /// memory management daemon is removed from the cluster.
    mode: ClusterConfigMode,

    pub const json_field_names = .{
        .instance_memory_allocation_percentage = "InstanceMemoryAllocationPercentage",
        .mode = "Mode",
    };
};
