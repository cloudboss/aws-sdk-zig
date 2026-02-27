pub const EntityType = enum {
    asset,
    data_product,

    pub const json_field_names = .{
        .asset = "ASSET",
        .data_product = "DATA_PRODUCT",
    };
};
