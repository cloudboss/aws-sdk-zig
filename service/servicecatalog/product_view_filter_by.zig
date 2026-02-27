pub const ProductViewFilterBy = enum {
    full_text_search,
    owner,
    product_type,
    source_product_id,

    pub const json_field_names = .{
        .full_text_search = "FullTextSearch",
        .owner = "Owner",
        .product_type = "ProductType",
        .source_product_id = "SourceProductId",
    };
};
