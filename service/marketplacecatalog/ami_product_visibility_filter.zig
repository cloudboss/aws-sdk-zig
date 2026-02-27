const AmiProductVisibilityString = @import("ami_product_visibility_string.zig").AmiProductVisibilityString;

/// Object that allows filtering on the visibility of the product in the AWS
/// Marketplace.
pub const AmiProductVisibilityFilter = struct {
    /// A string array of unique visibility values to be filtered on.
    value_list: ?[]const AmiProductVisibilityString,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
