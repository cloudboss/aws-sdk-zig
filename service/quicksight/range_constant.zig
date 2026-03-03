/// A structure that represents a range constant.
pub const RangeConstant = struct {
    /// The maximum value for a range constant.
    maximum: ?[]const u8 = null,

    /// The minimum value for a range constant.
    minimum: ?[]const u8 = null,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
    };
};
