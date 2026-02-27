const ClusterOnDemandOptions = @import("cluster_on_demand_options.zig").ClusterOnDemandOptions;
const ClusterSpotOptions = @import("cluster_spot_options.zig").ClusterSpotOptions;

/// Defines the instance capacity requirements for an instance group, including
/// configurations for both Spot and On-Demand capacity types.
pub const ClusterCapacityRequirements = struct {
    /// Configuration options specific to On-Demand instances.
    on_demand: ?ClusterOnDemandOptions,

    /// Configuration options specific to Spot instances.
    spot: ?ClusterSpotOptions,

    pub const json_field_names = .{
        .on_demand = "OnDemand",
        .spot = "Spot",
    };
};
