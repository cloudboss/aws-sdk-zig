/// The details of a capacity provider strategy.
pub const CapacityProviderStrategyItem = struct {
    /// The base value designates how many tasks, at a minimum, to run on the
    /// specified capacity provider. Only one capacity provider in a capacity
    /// provider strategy can have a base defined.
    /// If no value is specified, the default value of `0` is used.
    base: i32 = 0,

    /// The short name of the capacity provider.
    capacity_provider: []const u8,

    /// The weight value designates the relative percentage of the total number of
    /// tasks launched that should use the specified capacity provider. The weight
    /// value is taken into consideration after the
    /// base value, if defined, is satisfied.
    weight: i32 = 0,

    pub const json_field_names = .{
        .base = "base",
        .capacity_provider = "capacityProvider",
        .weight = "weight",
    };
};
