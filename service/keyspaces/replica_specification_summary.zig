const CapacitySpecificationSummary = @import("capacity_specification_summary.zig").CapacitySpecificationSummary;
const TableStatus = @import("table_status.zig").TableStatus;
const WarmThroughputSpecificationSummary = @import("warm_throughput_specification_summary.zig").WarmThroughputSpecificationSummary;

/// The Region-specific settings of a multi-Region table in the specified Amazon
/// Web Services Region.
///
/// If the multi-Region table is using provisioned capacity and has optional
/// auto scaling policies configured, note that the Region specific summary
/// returns both read and write capacity settings. But only Region specific read
/// capacity settings can be configured for a multi-Region table. In a
/// multi-Region table, your write capacity units will be synced across all
/// Amazon Web Services Regions to ensure that there is enough capacity to
/// replicate write events across Regions.
pub const ReplicaSpecificationSummary = struct {
    capacity_specification: ?CapacitySpecificationSummary = null,

    /// The Amazon Web Services Region.
    region: ?[]const u8 = null,

    /// The status of the multi-Region table in the specified Amazon Web Services
    /// Region.
    status: ?TableStatus = null,

    /// The warm throughput settings for this replica, including the current status
    /// and configured read and write capacity units.
    warm_throughput_specification: ?WarmThroughputSpecificationSummary = null,

    pub const json_field_names = .{
        .capacity_specification = "capacitySpecification",
        .region = "region",
        .status = "status",
        .warm_throughput_specification = "warmThroughputSpecification",
    };
};
