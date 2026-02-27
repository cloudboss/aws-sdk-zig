/// Configuration settings for an Amazon FSx for Lustre file system to be used
/// with the cluster.
pub const FSxLustreConfig = struct {
    /// The throughput capacity of the Amazon FSx for Lustre file system, measured
    /// in MB/s per TiB of storage.
    per_unit_storage_throughput: i32,

    /// The storage capacity of the Amazon FSx for Lustre file system, specified in
    /// gibibytes (GiB).
    size_in_gi_b: i32,

    pub const json_field_names = .{
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .size_in_gi_b = "SizeInGiB",
    };
};
