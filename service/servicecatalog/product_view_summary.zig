const ProductType = @import("product_type.zig").ProductType;

/// Summary information about a product view.
pub const ProductViewSummary = struct {
    /// The distributor of the product. Contact the product administrator for the
    /// significance of this value.
    distributor: ?[]const u8 = null,

    /// Indicates whether the product has a default path.
    /// If the product does not have a default path, call ListLaunchPaths
    /// to disambiguate between paths. Otherwise, ListLaunchPaths is not
    /// required, and the output of ProductViewSummary can be used directly with
    /// DescribeProvisioningParameters.
    has_default_path: bool = false,

    /// The product view identifier.
    id: ?[]const u8 = null,

    /// The name of the product.
    name: ?[]const u8 = null,

    /// The owner of the product. Contact the product administrator for the
    /// significance of
    /// this value.
    owner: ?[]const u8 = null,

    /// The product identifier.
    product_id: ?[]const u8 = null,

    /// Short description of the product.
    short_description: ?[]const u8 = null,

    /// The description of the support for this Product.
    support_description: ?[]const u8 = null,

    /// The email contact information to obtain support for this Product.
    support_email: ?[]const u8 = null,

    /// The URL information to obtain support for this Product.
    support_url: ?[]const u8 = null,

    /// The product type. Contact the product administrator for the significance of
    /// this
    /// value. If this value is `MARKETPLACE`, the product was created by Amazon Web
    /// Services Marketplace.
    @"type": ?ProductType = null,

    pub const json_field_names = .{
        .distributor = "Distributor",
        .has_default_path = "HasDefaultPath",
        .id = "Id",
        .name = "Name",
        .owner = "Owner",
        .product_id = "ProductId",
        .short_description = "ShortDescription",
        .support_description = "SupportDescription",
        .support_email = "SupportEmail",
        .support_url = "SupportUrl",
        .@"type" = "Type",
    };
};
