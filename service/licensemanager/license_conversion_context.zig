const ProductCodeListItem = @import("product_code_list_item.zig").ProductCodeListItem;

/// Information about a license type conversion task.
pub const LicenseConversionContext = struct {
    /// Product codes referred to in the license conversion process.
    product_codes: ?[]const ProductCodeListItem,

    /// The Usage operation value that corresponds to the license type you are
    /// converting your resource from. For more information about which platforms
    /// correspond to which usage operation values see [Sample data: usage operation
    /// by platform
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/billing-info-fields.html#billing-info)
    usage_operation: ?[]const u8,

    pub const json_field_names = .{
        .product_codes = "ProductCodes",
        .usage_operation = "UsageOperation",
    };
};
