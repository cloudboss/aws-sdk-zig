const DataProductVisibilityString = @import("data_product_visibility_string.zig").DataProductVisibilityString;

/// Object that allows filtering on the visibility of the product in the AWS
/// Marketplace.
pub const DataProductVisibilityFilter = struct {
    /// A string array of unique visibility values to be filtered on.
    value_list: ?[]const DataProductVisibilityString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
