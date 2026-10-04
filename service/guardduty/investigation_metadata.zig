const Product = @import("product.zig").Product;

/// Contains metadata about the product and version that produced an
/// investigation.
pub const InvestigationMetadata = struct {
    /// Information about the product that produced the investigation.
    product: Product,

    /// The version of the investigation engine that produced the results.
    version: []const u8,

    pub const json_field_names = .{
        .product = "Product",
        .version = "Version",
    };
};
