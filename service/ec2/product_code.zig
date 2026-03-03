const ProductCodeValues = @import("product_code_values.zig").ProductCodeValues;

/// Describes a product code.
pub const ProductCode = struct {
    /// The product code.
    product_code_id: ?[]const u8 = null,

    /// The type of product code.
    product_code_type: ?ProductCodeValues = null,
};
