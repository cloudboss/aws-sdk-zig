const ContainerProductVisibilityString = @import("container_product_visibility_string.zig").ContainerProductVisibilityString;

/// Object that allows filtering on the visibility of the product in the AWS
/// Marketplace.
pub const ContainerProductVisibilityFilter = struct {
    /// A string array of unique visibility values to be filtered on.
    value_list: ?[]const ContainerProductVisibilityString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
