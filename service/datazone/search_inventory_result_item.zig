const AssetItem = @import("asset_item.zig").AssetItem;
const DataProductResultItem = @import("data_product_result_item.zig").DataProductResultItem;
const GlossaryItem = @import("glossary_item.zig").GlossaryItem;
const GlossaryTermItem = @import("glossary_term_item.zig").GlossaryTermItem;

/// The details of the search results.
pub const SearchInventoryResultItem = union(enum) {
    /// The asset item included in the search results.
    asset_item: ?AssetItem,
    /// The data product.
    data_product_item: ?DataProductResultItem,
    /// The glossary item included in the search results.
    glossary_item: ?GlossaryItem,
    /// The glossary term item included in the search results.
    glossary_term_item: ?GlossaryTermItem,

    pub const json_field_names = .{
        .asset_item = "assetItem",
        .data_product_item = "dataProductItem",
        .glossary_item = "glossaryItem",
        .glossary_term_item = "glossaryTermItem",
    };
};
