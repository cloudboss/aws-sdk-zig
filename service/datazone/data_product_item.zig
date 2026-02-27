const DataProductItemType = @import("data_product_item_type.zig").DataProductItemType;

/// The data product.
pub const DataProductItem = struct {
    /// The glossary terms of the data product.
    glossary_terms: ?[]const []const u8,

    /// The ID of the data product.
    identifier: []const u8,

    /// The type of the data product.
    item_type: DataProductItemType,

    /// The revision of the data product.
    revision: ?[]const u8,

    pub const json_field_names = .{
        .glossary_terms = "glossaryTerms",
        .identifier = "identifier",
        .item_type = "itemType",
        .revision = "revision",
    };
};
