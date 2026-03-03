/// Strategy item for the capacity provider strategy that the service uses.
pub const AwsEcsServiceCapacityProviderStrategyDetails = struct {
    /// The minimum number of tasks to run on the capacity provider. Only one
    /// strategy item can specify a value for `Base`.
    ///
    /// The value must be between 0 and 100000.
    base: ?i32 = null,

    /// The short name of the capacity provider.
    capacity_provider: ?[]const u8 = null,

    /// The relative percentage of the total number of tasks that should use the
    /// capacity provider.
    ///
    /// If no weight is specified, the default value is 0. At least one capacity
    /// provider must have a weight greater than 0.
    ///
    /// The value can be between 0 and 1000.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .base = "Base",
        .capacity_provider = "CapacityProvider",
        .weight = "Weight",
    };
};
