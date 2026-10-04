/// Specifies the persistent EBS volume configuration for workers in a service
/// managed fleet.
pub const PersistentVolumeConfiguration = struct {
    /// The IOPS per persistent volume. The default is 3000.
    iops: i32 = 3000,

    /// The number of hours a persistent volume can remain unused before it is
    /// deleted. The default is 168 (7 days).
    last_used_ttl_hours: i32 = 168,

    /// The file system path where the persistent volume is mounted on the worker
    /// instance.
    mount_path: []const u8,

    /// The persistent volume size in GiB. The default is 250.
    size_gi_b: i32 = 250,

    /// The throughput per persistent volume in MiB. The default is 125.
    throughput_mi_b: i32 = 125,

    pub const json_field_names = .{
        .iops = "iops",
        .last_used_ttl_hours = "lastUsedTtlHours",
        .mount_path = "mountPath",
        .size_gi_b = "sizeGiB",
        .throughput_mi_b = "throughputMiB",
    };
};
