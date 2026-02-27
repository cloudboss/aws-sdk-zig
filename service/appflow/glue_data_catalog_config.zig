/// Specifies the configuration that Amazon AppFlow uses when it catalogs your
/// data with
/// the Glue Data Catalog. When Amazon AppFlow catalogs your data, it stores
/// metadata
/// in Data Catalog tables. This metadata represents the data that's transferred
/// by the
/// flow that you configure with these settings.
///
/// You can configure a flow with these settings only when the flow destination
/// is Amazon S3.
pub const GlueDataCatalogConfig = struct {
    /// The name of the Data Catalog database that stores the metadata tables that
    /// Amazon AppFlow creates in your Amazon Web Services account. These tables
    /// contain metadata for
    /// the data that's transferred by the flow that you configure with this
    /// parameter.
    ///
    /// When you configure a new flow with this parameter, you must specify an
    /// existing
    /// database.
    database_name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role that grants Amazon AppFlow the
    /// permissions it needs to create Data Catalog tables, databases, and
    /// partitions.
    ///
    /// For an example IAM policy that has the required permissions, see
    /// [Identity-based
    /// policy examples for Amazon
    /// AppFlow](https://docs.aws.amazon.com/appflow/latest/userguide/security_iam_id-based-policy-examples.html).
    role_arn: []const u8,

    /// A naming prefix for each Data Catalog table that Amazon AppFlow creates for
    /// the flow that you configure with this setting. Amazon AppFlow adds the
    /// prefix to the
    /// beginning of the each table name.
    table_prefix: []const u8,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .role_arn = "roleArn",
        .table_prefix = "tablePrefix",
    };
};
