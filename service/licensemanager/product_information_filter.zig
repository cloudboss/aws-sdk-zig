/// Describes product information filters.
pub const ProductInformationFilter = struct {
    /// Logical operator.
    product_information_filter_comparator: []const u8,

    /// Filter name.
    product_information_filter_name: []const u8,

    /// Filter value.
    product_information_filter_value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .product_information_filter_comparator = "ProductInformationFilterComparator",
        .product_information_filter_name = "ProductInformationFilterName",
        .product_information_filter_value = "ProductInformationFilterValue",
    };
};
