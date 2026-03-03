const DataProductVisibilityString = @import("data_product_visibility_string.zig").DataProductVisibilityString;

/// Object that contains summarized information about a data product.
pub const DataProductSummary = struct {
    /// The title of the data product.
    product_title: ?[]const u8 = null,

    /// The lifecycle of the data product.
    visibility: ?DataProductVisibilityString = null,

    pub const json_field_names = .{
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
