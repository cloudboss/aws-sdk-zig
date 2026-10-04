/// The definition of a vector attribute for a vector index.
pub const VectorAttributeDefinition = struct {
    /// The name of the vector attribute.
    attribute_name: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
    };
};
