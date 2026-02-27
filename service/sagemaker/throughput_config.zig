const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;

/// Used to set feature group throughput configuration. There are two modes:
/// `ON_DEMAND` and `PROVISIONED`. With on-demand mode, you are charged for data
/// reads and writes that your application performs on your feature group. You
/// do not need to specify read and write throughput because Feature Store
/// accommodates your workloads as they ramp up and down. You can switch a
/// feature group to on-demand only once in a 24 hour period. With provisioned
/// throughput mode, you specify the read and write capacity per second that you
/// expect your application to require, and you are billed based on those
/// limits. Exceeding provisioned throughput will result in your requests being
/// throttled.
///
/// Note: `PROVISIONED` throughput mode is supported only for feature groups
/// that are offline-only, or use the [ `Standard`
/// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OnlineStoreConfig.html#sagemaker-Type-OnlineStoreConfig-StorageType) tier online store.
pub const ThroughputConfig = struct {
    /// For provisioned feature groups with online store enabled, this indicates the
    /// read throughput you are billed for and can consume without throttling.
    ///
    /// This field is not applicable for on-demand feature groups.
    provisioned_read_capacity_units: ?i32,

    /// For provisioned feature groups, this indicates the write throughput you are
    /// billed for and can consume without throttling.
    ///
    /// This field is not applicable for on-demand feature groups.
    provisioned_write_capacity_units: ?i32,

    /// The mode used for your feature group throughput: `ON_DEMAND` or
    /// `PROVISIONED`.
    throughput_mode: ThroughputMode,

    pub const json_field_names = .{
        .provisioned_read_capacity_units = "ProvisionedReadCapacityUnits",
        .provisioned_write_capacity_units = "ProvisionedWriteCapacityUnits",
        .throughput_mode = "ThroughputMode",
    };
};
