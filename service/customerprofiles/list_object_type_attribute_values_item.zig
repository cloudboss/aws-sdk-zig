/// Represents an item in the list of object type attribute values with its
/// associated metadata.
pub const ListObjectTypeAttributeValuesItem = struct {
    /// The timestamp of when the object type attribute value was most recently
    /// updated.
    last_updated_at: i64,

    /// The actual value of the object type attribute.
    value: []const u8,

    pub const json_field_names = .{
        .last_updated_at = "LastUpdatedAt",
        .value = "Value",
    };
};
