/// The default capacity provider strategy for the cluster. The default capacity
/// provider strategy is used when services or tasks are run without a specified
/// launch type or capacity provider strategy.
pub const AwsEcsClusterDefaultCapacityProviderStrategyDetails = struct {
    /// The minimum number of tasks to run on the specified capacity provider.
    base: ?i32 = null,

    /// The name of the capacity provider.
    capacity_provider: ?[]const u8 = null,

    /// The relative percentage of the total number of tasks launched that should
    /// use the capacity provider.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .base = "Base",
        .capacity_provider = "CapacityProvider",
        .weight = "Weight",
    };
};
