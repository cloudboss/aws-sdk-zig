/// A structure that describes a target catalog for resource linking.
pub const TargetRedshiftCatalog = struct {
    /// The Amazon Resource Name (ARN) of the catalog resource.
    catalog_arn: []const u8,

    pub const json_field_names = .{
        .catalog_arn = "CatalogArn",
    };
};
