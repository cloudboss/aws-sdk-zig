const ConstantType = @import("constant_type.zig").ConstantType;
const CollectiveConstantEntry = @import("collective_constant_entry.zig").CollectiveConstantEntry;

/// The definition for a `TopicConstantValue`.
pub const TopicConstantValue = struct {
    /// The constant type of a `TopicConstantValue`.
    constant_type: ?ConstantType = null,

    /// The maximum for the `TopicConstantValue`.
    maximum: ?[]const u8 = null,

    /// The minimum for the `TopicConstantValue`.
    minimum: ?[]const u8 = null,

    /// The value of the `TopicConstantValue`.
    value: ?[]const u8 = null,

    /// The value list of the `TopicConstantValue`.
    value_list: ?[]const CollectiveConstantEntry = null,

    pub const json_field_names = .{
        .constant_type = "ConstantType",
        .maximum = "Maximum",
        .minimum = "Minimum",
        .value = "Value",
        .value_list = "ValueList",
    };
};
