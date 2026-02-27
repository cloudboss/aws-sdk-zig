const MetadataAttributeValue = @import("metadata_attribute_value.zig").MetadataAttributeValue;

/// Contains information about a metadata attribute.
pub const MetadataAttribute = struct {
    /// The key of the metadata attribute.
    key: []const u8,

    /// Contains the value of the metadata attribute.
    value: MetadataAttributeValue,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
