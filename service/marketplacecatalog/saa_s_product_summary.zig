const SaaSProductVisibilityString = @import("saa_s_product_visibility_string.zig").SaaSProductVisibilityString;

/// Object that contains summarized information about a SaaS product.
pub const SaaSProductSummary = struct {
    /// The title of the SaaS product.
    product_title: ?[]const u8 = null,

    /// The lifecycle of the SaaS product.
    visibility: ?SaaSProductVisibilityString = null,

    pub const json_field_names = .{
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
