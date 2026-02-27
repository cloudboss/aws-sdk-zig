pub const InventorySearchScope = enum {
    asset,
    glossary,
    glossary_term,
    data_product,

    pub const json_field_names = .{
        .asset = "ASSET",
        .glossary = "GLOSSARY",
        .glossary_term = "GLOSSARY_TERM",
        .data_product = "DATA_PRODUCT",
    };
};
