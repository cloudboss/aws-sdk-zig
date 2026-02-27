const MachineLearningProductVisibilityString = @import("machine_learning_product_visibility_string.zig").MachineLearningProductVisibilityString;

/// A summary of a machine learning product.
pub const MachineLearningProductSummary = struct {
    /// The title of the machine learning product.
    product_title: ?[]const u8,

    /// The visibility status of the machine learning product. Valid values are
    /// `Limited`, `Public`, `Restricted`, and `Draft`.
    visibility: ?MachineLearningProductVisibilityString,

    pub const json_field_names = .{
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
