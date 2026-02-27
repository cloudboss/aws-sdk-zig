/// Item that contains the attribute and when it was last updated.
pub const ListObjectTypeAttributeItem = struct {
    /// Name of the attribute.
    attribute_name: []const u8,

    /// When the attribute was last updated.
    last_updated_at: i64,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .last_updated_at = "LastUpdatedAt",
    };
};
