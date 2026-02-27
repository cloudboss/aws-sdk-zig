/// A disk that should be replicated.
pub const RecoveryInstanceDataReplicationInfoReplicatedDisk = struct {
    /// The size of the replication backlog in bytes.
    backlogged_storage_bytes: i64 = 0,

    /// The name of the device.
    device_name: ?[]const u8,

    /// The amount of data replicated so far in bytes.
    replicated_storage_bytes: i64 = 0,

    /// The amount of data to be rescanned in bytes.
    rescanned_storage_bytes: i64 = 0,

    /// The total amount of data to be replicated in bytes.
    total_storage_bytes: i64 = 0,

    pub const json_field_names = .{
        .backlogged_storage_bytes = "backloggedStorageBytes",
        .device_name = "deviceName",
        .replicated_storage_bytes = "replicatedStorageBytes",
        .rescanned_storage_bytes = "rescannedStorageBytes",
        .total_storage_bytes = "totalStorageBytes",
    };
};
