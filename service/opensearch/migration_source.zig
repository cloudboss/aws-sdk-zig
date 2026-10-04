/// The source configuration for a migration, specifying the data source from
/// which to export saved objects.
pub const MigrationSource = struct {
    /// The Amazon Resource Name (ARN) of the data source to migrate saved objects
    /// from.
    datasource_arn: []const u8,

    pub const json_field_names = .{
        .datasource_arn = "datasourceArn",
    };
};
