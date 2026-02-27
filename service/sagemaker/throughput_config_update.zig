const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;

/// The new throughput configuration for the feature group. You can switch
/// between on-demand and provisioned modes or update the read / write capacity
/// of provisioned feature groups. You can switch a feature group to on-demand
/// only once in a 24 hour period.
pub const ThroughputConfigUpdate = struct {
    /// For provisioned feature groups with online store enabled, this indicates the
    /// read throughput you are billed for and can consume without throttling.
    provisioned_read_capacity_units: ?i32,

    /// For provisioned feature groups, this indicates the write throughput you are
    /// billed for and can consume without throttling.
    provisioned_write_capacity_units: ?i32,

    /// Target throughput mode of the feature group. Throughput update is an
    /// asynchronous operation, and the outcome should be monitored by polling
    /// `LastUpdateStatus` field in `DescribeFeatureGroup` response. You cannot
    /// update a feature group's throughput while another update is in progress.
    throughput_mode: ?ThroughputMode,

    pub const json_field_names = .{
        .provisioned_read_capacity_units = "ProvisionedReadCapacityUnits",
        .provisioned_write_capacity_units = "ProvisionedWriteCapacityUnits",
        .throughput_mode = "ThroughputMode",
    };
};
