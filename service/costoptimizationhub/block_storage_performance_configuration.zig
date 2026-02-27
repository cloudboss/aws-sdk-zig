/// Describes the Amazon Elastic Block Store performance configuration of the
/// current and recommended resource configuration for a recommendation.
pub const BlockStoragePerformanceConfiguration = struct {
    /// The number of I/O operations per second.
    iops: ?f64,

    /// The throughput that the volume supports.
    throughput: ?f64,

    pub const json_field_names = .{
        .iops = "iops",
        .throughput = "throughput",
    };
};
