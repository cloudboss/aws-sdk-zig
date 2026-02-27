const SaaSProductVisibilityString = @import("saa_s_product_visibility_string.zig").SaaSProductVisibilityString;

/// Object that allows filtering on the visibility of the product in the AWS
/// Marketplace.
pub const SaaSProductVisibilityFilter = struct {
    /// A string array of unique visibility values to be filtered on.
    value_list: ?[]const SaaSProductVisibilityString,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
