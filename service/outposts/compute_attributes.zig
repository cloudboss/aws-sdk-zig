const AssetInstanceTypeCapacity = @import("asset_instance_type_capacity.zig").AssetInstanceTypeCapacity;
const ComputeAssetState = @import("compute_asset_state.zig").ComputeAssetState;

/// Information about compute hardware assets.
pub const ComputeAttributes = struct {
    /// The host ID of the Dedicated Host on the asset.
    host_id: ?[]const u8,

    /// A list of the names of instance families that are currently associated with
    /// a given
    /// asset.
    instance_families: ?[]const []const u8,

    /// The instance type capacities configured for this asset. This can be changed
    /// through a
    /// capacity task.
    instance_type_capacities: ?[]const AssetInstanceTypeCapacity,

    /// The maximum number of vCPUs possible for the specified asset.
    max_vcpus: ?i32,

    /// The state.
    ///
    /// * ACTIVE - The asset is available and can provide capacity for new compute
    /// resources.
    ///
    /// * ISOLATED - The asset is undergoing maintenance and can't provide capacity
    ///   for new
    /// compute resources. Existing compute resources on the asset are not affected.
    ///
    /// * RETIRING - The underlying hardware for the asset is degraded. Capacity for
    ///   new compute
    /// resources is reduced. Amazon Web Services sends notifications for resources
    /// that must be stopped before
    /// the asset can be replaced.
    state: ?ComputeAssetState,

    pub const json_field_names = .{
        .host_id = "HostId",
        .instance_families = "InstanceFamilies",
        .instance_type_capacities = "InstanceTypeCapacities",
        .max_vcpus = "MaxVcpus",
        .state = "State",
    };
};
