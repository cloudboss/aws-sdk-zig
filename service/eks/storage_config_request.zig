const BlockStorage = @import("block_storage.zig").BlockStorage;

/// Request to update the configuration of the storage capability of your EKS
/// Auto Mode
/// cluster. For example, enable the capability. For more information, see EKS
/// Auto Mode
/// block storage capability in the *Amazon EKS User Guide*.
pub const StorageConfigRequest = struct {
    /// Request to configure EBS Block Storage settings for your EKS Auto Mode
    /// cluster.
    block_storage: ?BlockStorage = null,

    pub const json_field_names = .{
        .block_storage = "blockStorage",
    };
};
