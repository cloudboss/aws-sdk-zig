const ProductCodeType = @import("product_code_type.zig").ProductCodeType;

/// Information about a single product code.
pub const ProductCodeListItem = struct {
    /// For Amazon Web Services Marketplace components, this contains the product
    /// code ID that can be stamped onto
    /// an EC2 AMI to ensure that components are billed correctly. If this property
    /// is empty,
    /// it might mean that the component is not published.
    product_code_id: []const u8,

    /// The owner of the product code that's billed. If this property is
    /// empty, it might mean that the component is not published.
    product_code_type: ProductCodeType,

    pub const json_field_names = .{
        .product_code_id = "productCodeId",
        .product_code_type = "productCodeType",
    };
};
