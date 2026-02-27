/// Identifies the schema Amazon Resource Name (ARN) and facet name for the
/// typed
/// link.
pub const TypedLinkSchemaAndFacetName = struct {
    /// The Amazon Resource Name (ARN) that is associated with the schema. For more
    /// information, see arns.
    schema_arn: []const u8,

    /// The unique name of the typed link facet.
    typed_link_name: []const u8,

    pub const json_field_names = .{
        .schema_arn = "SchemaArn",
        .typed_link_name = "TypedLinkName",
    };
};
