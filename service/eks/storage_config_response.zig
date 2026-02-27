const BlockStorage = @import("block_storage.zig").BlockStorage;

/// Indicates the status of the request to update the block storage capability
/// of your EKS
/// Auto Mode cluster.
pub const StorageConfigResponse = struct {
    /// Indicates the current configuration of the block storage capability on your
    /// EKS Auto
    /// Mode cluster. For example, if the capability is enabled or disabled.
    block_storage: ?BlockStorage,

    pub const json_field_names = .{
        .block_storage = "blockStorage",
    };
};
