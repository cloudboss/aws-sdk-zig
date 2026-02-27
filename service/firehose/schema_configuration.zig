/// Specifies the schema to which you want Firehose to configure your data
/// before it writes it to Amazon S3. This parameter is required if `Enabled` is
/// set
/// to true.
pub const SchemaConfiguration = struct {
    /// The ID of the Amazon Web Services Glue Data Catalog. If you don't supply
    /// this, the
    /// Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8,

    /// Specifies the name of the Amazon Web Services Glue database that contains
    /// the schema for
    /// the output data.
    ///
    /// If the `SchemaConfiguration` request parameter is used as part of invoking
    /// the `CreateDeliveryStream` API, then the `DatabaseName` property
    /// is required and its value must be specified.
    database_name: ?[]const u8,

    /// If you don't specify an Amazon Web Services Region, the default is the
    /// current
    /// Region.
    region: ?[]const u8,

    /// The role that Firehose can use to access Amazon Web Services Glue. This
    /// role must be in the same account you use for Firehose. Cross-account roles
    /// aren't allowed.
    ///
    /// If the `SchemaConfiguration` request parameter is used as part of invoking
    /// the `CreateDeliveryStream` API, then the `RoleARN` property is
    /// required and its value must be specified.
    role_arn: ?[]const u8,

    /// Specifies the Amazon Web Services Glue table that contains the column
    /// information that
    /// constitutes your data schema.
    ///
    /// If the `SchemaConfiguration` request parameter is used as part of invoking
    /// the `CreateDeliveryStream` API, then the `TableName` property is
    /// required and its value must be specified.
    table_name: ?[]const u8,

    /// Specifies the table version for the output data schema. If you don't specify
    /// this
    /// version ID, or if you set it to `LATEST`, Firehose uses the most
    /// recent version. This means that any updates to the table are automatically
    /// picked
    /// up.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .region = "Region",
        .role_arn = "RoleARN",
        .table_name = "TableName",
        .version_id = "VersionId",
    };
};
