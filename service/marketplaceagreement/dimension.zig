/// Defines the dimensions that the acceptor has purchased from the overall set
/// of dimensions presented in the rate card.
pub const Dimension = struct {
    /// The name of key value of the dimension.
    dimension_key: []const u8,

    /// The number of units of the dimension the acceptor has purchased.
    ///
    /// For Agreements with `ConfigurableUpfrontPricingTerm`, the `RateCard` section
    /// will define the prices and dimensions defined by the seller (proposer),
    /// whereas the `Configuration` section will define the actual dimensions,
    /// prices, and units the buyer has chosen to accept.
    dimension_value: i32 = 0,

    pub const json_field_names = .{
        .dimension_key = "dimensionKey",
        .dimension_value = "dimensionValue",
    };
};
