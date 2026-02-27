const InstanceAttributeType = @import("instance_attribute_type.zig").InstanceAttributeType;

/// A toggle for an individual feature at the instance level.
pub const Attribute = struct {
    /// The type of attribute.
    attribute_type: ?InstanceAttributeType,

    /// The value of the attribute.
    value: ?[]const u8,

    pub const json_field_names = .{
        .attribute_type = "AttributeType",
        .value = "Value",
    };
};
