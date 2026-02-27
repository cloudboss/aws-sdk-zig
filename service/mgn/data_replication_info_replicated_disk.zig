/// Request to query disks replicated.
pub const DataReplicationInfoReplicatedDisk = struct {
    /// Request to query data replication backlog size in bytes.
    backlogged_storage_bytes: i64 = 0,

    /// Request to query device name.
    device_name: ?[]const u8,

    /// Request to query amount of data replicated in bytes.
    replicated_storage_bytes: i64 = 0,

    /// Request to query amount of data rescanned in bytes.
    rescanned_storage_bytes: i64 = 0,

    /// Request to query total amount of data replicated in bytes.
    total_storage_bytes: i64 = 0,

    pub const json_field_names = .{
        .backlogged_storage_bytes = "backloggedStorageBytes",
        .device_name = "deviceName",
        .replicated_storage_bytes = "replicatedStorageBytes",
        .rescanned_storage_bytes = "rescannedStorageBytes",
        .total_storage_bytes = "totalStorageBytes",
    };
};
