/// The structure that configures parameters such as `ThroughputHintInMBs` for a
/// stream configured with
/// Direct PUT as a source.
pub const DirectPutSourceConfiguration = struct {
    /// The value that you configure for this parameter is for information purpose
    /// only and
    /// does not affect Firehose delivery throughput limit. You can use the
    /// [Firehose Limits
    /// form](https://support.console.aws.amazon.com/support/home#/case/create%3FissueType=service-limit-increase%26limitType=kinesis-firehose-limits) to request a throughput limit increase.
    throughput_hint_in_m_bs: i32,

    pub const json_field_names = .{
        .throughput_hint_in_m_bs = "ThroughputHintInMBs",
    };
};
