/// Entitlements granted to the acceptor of fixed upfront as part of agreement
/// execution.
pub const GrantItem = struct {
    /// Unique dimension key defined in the product document. Dimensions represent
    /// categories of capacity in a product and are specified when the product is
    /// listed in AWS Marketplace.
    dimension_key: ?[]const u8 = null,

    /// Maximum amount of capacity that the buyer can be entitled to the given
    /// dimension of the product. If `MaxQuantity` is not provided, the buyer will
    /// be able to use an unlimited amount of the given dimension.
    max_quantity: i32 = 1,

    pub const json_field_names = .{
        .dimension_key = "dimensionKey",
        .max_quantity = "maxQuantity",
    };
};
