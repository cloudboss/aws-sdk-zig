/// Dimensional price rate.
pub const DimensionalPriceRate = struct {
    /// Description of the price rate.
    description: ?[]const u8 = null,

    /// Dimension for the price rate.
    dimension: ?[]const u8 = null,

    /// Single-dimensional rate information.
    price: ?[]const u8 = null,

    /// Unit associated with the price.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .dimension = "dimension",
        .price = "price",
        .unit = "unit",
    };
};
