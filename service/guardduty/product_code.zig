/// Contains information about the product code for the EC2 instance.
pub const ProductCode = struct {
    /// The product code information.
    code: ?[]const u8 = null,

    /// The product code type.
    product_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .product_type = "ProductType",
    };
};
