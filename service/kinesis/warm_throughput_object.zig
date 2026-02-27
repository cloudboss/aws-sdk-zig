/// Represents the warm throughput configuration on the stream. This is only
/// present for On-Demand Kinesis Data Streams in accounts that have
/// `MinimumThroughputBillingCommitment` enabled.
pub const WarmThroughputObject = struct {
    /// The current warm throughput value on the stream. This is the write
    /// throughput in MiBps that the stream is currently scaled to handle.
    current_mi_bps: ?i32,

    /// The target warm throughput value on the stream. This indicates that the
    /// stream is currently scaling towards this target value.
    target_mi_bps: ?i32,

    pub const json_field_names = .{
        .current_mi_bps = "CurrentMiBps",
        .target_mi_bps = "TargetMiBps",
    };
};
