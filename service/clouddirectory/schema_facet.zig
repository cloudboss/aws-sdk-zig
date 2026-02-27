/// A facet.
pub const SchemaFacet = struct {
    /// The name of the facet. If this value is set, SchemaArn must also be set.
    facet_name: ?[]const u8,

    /// The ARN of the schema that contains the facet with no minor component. See
    /// arns and [In-Place Schema
    /// Upgrade](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_inplaceschemaupgrade.html) for a description of when to provide minor versions.
    /// If this value is set, FacetName must also be set.
    schema_arn: ?[]const u8,

    pub const json_field_names = .{
        .facet_name = "FacetName",
        .schema_arn = "SchemaArn",
    };
};
