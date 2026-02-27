const aws = @import("aws");

/// Represents an item in the catalog with its complete set of attributes and
/// metadata.
pub const CatalogItem = struct {
    /// Supplementary information about the catalog item beyond the basic
    /// description.
    additional_information: ?[]const u8,

    /// Additional attributes or properties associated with the catalog item stored
    /// as key-value pairs.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The category to which the catalog item belongs.
    category: ?[]const u8,

    /// The product code or SKU of the catalog item.
    code: ?[]const u8,

    /// The timestamp when the catalog item was created.
    created_at: ?i64,

    /// A detailed description of the catalog item.
    description: ?[]const u8,

    /// The unique identifier for the catalog item.
    id: ?[]const u8,

    /// The URL link to the item's image.
    image_link: ?[]const u8,

    /// The URL link to the item's detailed page or external resource.
    link: ?[]const u8,

    /// The display name of the catalog item.
    name: ?[]const u8,

    /// The price of the catalog item.
    price: ?[]const u8,

    /// The type classification of the catalog item.
    type: ?[]const u8,

    /// The timestamp when the catalog item was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .additional_information = "AdditionalInformation",
        .attributes = "Attributes",
        .category = "Category",
        .code = "Code",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .image_link = "ImageLink",
        .link = "Link",
        .name = "Name",
        .price = "Price",
        .type = "Type",
        .updated_at = "UpdatedAt",
    };
};
