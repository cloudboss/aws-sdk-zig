const ContainerProductVisibilityString = @import("container_product_visibility_string.zig").ContainerProductVisibilityString;

/// Object that contains summarized information about a container product.
pub const ContainerProductSummary = struct {
    /// The title of the container product.
    product_title: ?[]const u8,

    /// The lifecycle of the product.
    visibility: ?ContainerProductVisibilityString,

    pub const json_field_names = .{
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
