/// Dimensional price rate.
pub const DimensionalPriceRate = struct {
    /// Description of the price rate.
    description: ?[]const u8,

    /// Dimension for the price rate.
    dimension: ?[]const u8,

    /// Single-dimensional rate information.
    price: ?[]const u8,

    /// Unit associated with the price.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .dimension = "dimension",
        .price = "price",
        .unit = "unit",
    };
};
