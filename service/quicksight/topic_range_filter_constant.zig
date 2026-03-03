const ConstantType = @import("constant_type.zig").ConstantType;
const RangeConstant = @import("range_constant.zig").RangeConstant;

/// A constant value that is used in a range filter to specify the endpoints of
/// the range.
pub const TopicRangeFilterConstant = struct {
    /// The data type of the constant value that is used in a range filter. Valid
    /// values for this structure are `RANGE`.
    constant_type: ?ConstantType = null,

    /// The value of the constant that is used to specify the endpoints of a range
    /// filter.
    range_constant: ?RangeConstant = null,

    pub const json_field_names = .{
        .constant_type = "ConstantType",
        .range_constant = "RangeConstant",
    };
};
