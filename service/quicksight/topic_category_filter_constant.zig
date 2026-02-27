const CollectiveConstant = @import("collective_constant.zig").CollectiveConstant;
const ConstantType = @import("constant_type.zig").ConstantType;

/// A constant used in a category filter.
pub const TopicCategoryFilterConstant = struct {
    /// A collective constant used in a category filter. This element is used to
    /// specify a list of values for the constant.
    collective_constant: ?CollectiveConstant,

    /// The type of category filter constant. This element is used to specify
    /// whether a constant is a singular or collective. Valid values are `SINGULAR`
    /// and `COLLECTIVE`.
    constant_type: ?ConstantType,

    /// A singular constant used in a category filter. This element is used to
    /// specify a single value for the constant.
    singular_constant: ?[]const u8,

    pub const json_field_names = .{
        .collective_constant = "CollectiveConstant",
        .constant_type = "ConstantType",
        .singular_constant = "SingularConstant",
    };
};
