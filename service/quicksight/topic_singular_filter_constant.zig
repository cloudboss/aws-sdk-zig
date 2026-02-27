const ConstantType = @import("constant_type.zig").ConstantType;

/// A structure that represents a singular filter constant, used in filters to
/// specify a single value to match against.
pub const TopicSingularFilterConstant = struct {
    /// The type of the singular filter constant. Valid values for this structure
    /// are `SINGULAR`.
    constant_type: ?ConstantType,

    /// The value of the singular filter constant.
    singular_constant: ?[]const u8,

    pub const json_field_names = .{
        .constant_type = "ConstantType",
        .singular_constant = "SingularConstant",
    };
};
