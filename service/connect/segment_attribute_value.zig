const aws = @import("aws");

/// A value for a segment attribute. This is structured as a map where the key
/// is `valueString` and the
/// value is a string.
pub const SegmentAttributeValue = struct {
    /// The value of a segment attribute that has to be a valid ARN. This is only
    /// supported for system-defined
    /// attributes, not for user-defined attributes.
    value_arn: ?[]const u8 = null,

    /// The value of a segment attribute.
    value_integer: ?i32 = null,

    /// The value of a segment attribute. This is only supported for system-defined
    /// attributes, not for user-defined
    /// attributes.
    value_list: ?[]const SegmentAttributeValue = null,

    /// The value of a segment attribute.
    value_map: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// The value of a segment attribute.
    value_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .value_arn = "ValueArn",
        .value_integer = "ValueInteger",
        .value_list = "ValueList",
        .value_map = "ValueMap",
        .value_string = "ValueString",
    };
};
