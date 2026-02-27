const AmiProductVisibilityString = @import("ami_product_visibility_string.zig").AmiProductVisibilityString;

/// Object that contains summarized information about an AMI product.
pub const AmiProductSummary = struct {
    /// The title of the AMI product.
    product_title: ?[]const u8,

    /// The lifecycle of the AMI product.
    visibility: ?AmiProductVisibilityString,

    pub const json_field_names = .{
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
