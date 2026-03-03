const OnDemandThroughputOverride = @import("on_demand_throughput_override.zig").OnDemandThroughputOverride;
const ProvisionedThroughputOverride = @import("provisioned_throughput_override.zig").ProvisionedThroughputOverride;

/// Represents the properties of a replica global secondary index.
pub const ReplicaGlobalSecondaryIndex = struct {
    /// The name of the global secondary index.
    index_name: []const u8,

    /// Overrides the maximum on-demand throughput settings for the specified global
    /// secondary
    /// index in the specified replica table.
    on_demand_throughput_override: ?OnDemandThroughputOverride = null,

    /// Replica table GSI-specific provisioned throughput. If not specified, uses
    /// the source
    /// table GSI's read capacity settings.
    provisioned_throughput_override: ?ProvisionedThroughputOverride = null,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .on_demand_throughput_override = "OnDemandThroughputOverride",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
    };
};
