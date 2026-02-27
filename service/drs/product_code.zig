const ProductCodeMode = @import("product_code_mode.zig").ProductCodeMode;

/// Properties of a product code associated with a volume.
pub const ProductCode = struct {
    /// Id of a product code associated with a volume.
    product_code_id: ?[]const u8,

    /// Mode of a product code associated with a volume.
    product_code_mode: ?ProductCodeMode,

    pub const json_field_names = .{
        .product_code_id = "productCodeId",
        .product_code_mode = "productCodeMode",
    };
};
