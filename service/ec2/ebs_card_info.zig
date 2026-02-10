/// Describes the performance characteristics of an EBS card on the instance
/// type.
pub const EbsCardInfo = struct {
    /// The baseline bandwidth performance for the EBS card, in Mbps.
    baseline_bandwidth_in_mbps: ?i32,

    /// The baseline IOPS performance for the EBS card.
    baseline_iops: ?i32,

    /// The baseline throughput performance for the EBS card, in MBps.
    baseline_throughput_in_m_bps: ?f64,

    /// The index of the EBS card.
    ebs_card_index: ?i32,

    /// The maximum bandwidth performance for the EBS card, in Mbps.
    maximum_bandwidth_in_mbps: ?i32,

    /// The maximum IOPS performance for the EBS card.
    maximum_iops: ?i32,

    /// The maximum throughput performance for the EBS card, in MBps.
    maximum_throughput_in_m_bps: ?f64,
};
