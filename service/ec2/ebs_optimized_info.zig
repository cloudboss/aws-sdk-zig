/// Describes the optimized EBS performance for supported instance types.
pub const EbsOptimizedInfo = struct {
    /// The baseline bandwidth performance for an EBS-optimized instance type, in
    /// Mbps.
    baseline_bandwidth_in_mbps: ?i32,

    /// The baseline input/output storage operations per seconds for an
    /// EBS-optimized instance
    /// type.
    baseline_iops: ?i32,

    /// The baseline throughput performance for an EBS-optimized instance type, in
    /// MB/s.
    baseline_throughput_in_m_bps: ?f64,

    /// The maximum bandwidth performance for an EBS-optimized instance type, in
    /// Mbps.
    maximum_bandwidth_in_mbps: ?i32,

    /// The maximum input/output storage operations per second for an EBS-optimized
    /// instance
    /// type.
    maximum_iops: ?i32,

    /// The maximum throughput performance for an EBS-optimized instance type, in
    /// MB/s.
    maximum_throughput_in_m_bps: ?f64,
};
