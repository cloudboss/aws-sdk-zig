const ConstantType = @import("constant_type.zig").ConstantType;

/// The definition for a `CollectiveConstantEntry`.
pub const CollectiveConstantEntry = struct {
    /// The `ConstantType` of a `CollectiveConstantEntry`.
    constant_type: ?ConstantType = null,

    /// The value of a `CollectiveConstantEntry`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .constant_type = "ConstantType",
        .value = "Value",
    };
};
