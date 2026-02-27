/// A unique identifier for an attribute.
pub const AttributeKey = struct {
    /// The name of the facet that the attribute exists within.
    facet_name: []const u8,

    /// The name of the attribute.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the schema that contains the facet and
    /// attribute.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .facet_name = "FacetName",
        .name = "Name",
        .schema_arn = "SchemaArn",
    };
};
