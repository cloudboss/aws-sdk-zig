const OnDemandThroughputOverride = @import("on_demand_throughput_override.zig").OnDemandThroughputOverride;
const ProvisionedThroughputOverride = @import("provisioned_throughput_override.zig").ProvisionedThroughputOverride;
const GlobalSecondaryIndexWarmThroughputDescription = @import("global_secondary_index_warm_throughput_description.zig").GlobalSecondaryIndexWarmThroughputDescription;

/// Represents the properties of a replica global secondary index.
pub const ReplicaGlobalSecondaryIndexDescription = struct {
    /// The name of the global secondary index.
    index_name: ?[]const u8,

    /// Overrides the maximum on-demand throughput for the specified global
    /// secondary index in
    /// the specified replica table.
    on_demand_throughput_override: ?OnDemandThroughputOverride,

    /// If not described, uses the source table GSI's read capacity settings.
    provisioned_throughput_override: ?ProvisionedThroughputOverride,

    /// Represents the warm throughput of the global secondary index for this
    /// replica.
    warm_throughput: ?GlobalSecondaryIndexWarmThroughputDescription,
};
