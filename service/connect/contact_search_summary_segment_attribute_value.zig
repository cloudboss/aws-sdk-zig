const aws = @import("aws");

const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;

/// The value of a segment attribute. This is structured as a map with a single
/// key-value pair. The key
/// 'valueString' indicates that the attribute type is a string, and its
/// corresponding value is the actual string value
/// of the segment attribute.
pub const ContactSearchSummarySegmentAttributeValue = struct {
    /// The key and value of a segment attribute.
    value_map: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// The value of a segment attribute represented as a string.
    value_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .value_map = "ValueMap",
        .value_string = "ValueString",
    };
};
