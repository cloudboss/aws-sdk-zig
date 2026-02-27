/// Defines the per unit rates for each individual product dimension.
pub const RateCardItem = struct {
    /// Dimension for which the given entitlement applies. Dimensions represent
    /// categories of capacity in a product and are specified when the product is
    /// listed in AWS Marketplace.
    dimension_key: ?[]const u8,

    /// Per unit price for the product dimension that’s used for calculating the
    /// amount to be charged.
    price: ?[]const u8,

    pub const json_field_names = .{
        .dimension_key = "dimensionKey",
        .price = "price",
    };
};
