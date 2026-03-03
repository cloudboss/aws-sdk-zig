const AmazonRedshiftAdvancedOption = @import("amazon_redshift_advanced_option.zig").AmazonRedshiftAdvancedOption;
const Option = @import("option.zig").Option;

/// Specifies an Amazon Redshift node.
pub const AmazonRedshiftNodeData = struct {
    /// The access type for the Redshift connection. Can be a direct connection or
    /// catalog connections.
    access_type: ?[]const u8 = null,

    /// Specifies how writing to a Redshift cluser will occur.
    action: ?[]const u8 = null,

    /// Optional values when connecting to the Redshift cluster.
    advanced_options: ?[]const AmazonRedshiftAdvancedOption = null,

    /// The name of the Glue Data Catalog database when working with a data catalog.
    catalog_database: ?Option = null,

    /// The Redshift schema name when working with a data catalog.
    catalog_redshift_schema: ?[]const u8 = null,

    /// The database table to read from.
    catalog_redshift_table: ?[]const u8 = null,

    /// The Glue Data Catalog table name when working with a data catalog.
    catalog_table: ?Option = null,

    /// The Glue connection to the Redshift cluster.
    connection: ?Option = null,

    /// Specifies the name of the connection that is associated with the catalog
    /// table used.
    crawler_connection: ?[]const u8 = null,

    /// Optional. The role name use when connection to S3. The IAM role ill default
    /// to the role on the job when left blank.
    iam_role: ?Option = null,

    /// The action used when to detemine how a MERGE in a Redshift sink will be
    /// handled.
    merge_action: ?[]const u8 = null,

    /// The SQL used in a custom merge to deal with matching records.
    merge_clause: ?[]const u8 = null,

    /// The action used when to detemine how a MERGE in a Redshift sink will be
    /// handled when an existing record matches a new record.
    merge_when_matched: ?[]const u8 = null,

    /// The action used when to detemine how a MERGE in a Redshift sink will be
    /// handled when an existing record doesn't match a new record.
    merge_when_not_matched: ?[]const u8 = null,

    /// The SQL used before a MERGE or APPEND with upsert is run.
    post_action: ?[]const u8 = null,

    /// The SQL used before a MERGE or APPEND with upsert is run.
    pre_action: ?[]const u8 = null,

    /// The SQL used to fetch the data from a Redshift sources when the SourceType
    /// is 'query'.
    sample_query: ?[]const u8 = null,

    /// The Redshift schema name when working with a direct connection.
    schema: ?Option = null,

    /// The list of column names used to determine a matching record when doing a
    /// MERGE or APPEND with upsert.
    selected_columns: ?[]const Option = null,

    /// The source type to specify whether a specific table is the source or a
    /// custom query.
    source_type: ?[]const u8 = null,

    /// The name of the temporary staging table that is used when doing a MERGE or
    /// APPEND with upsert.
    staging_table: ?[]const u8 = null,

    /// The Redshift table name when working with a direct connection.
    table: ?Option = null,

    /// Specifies the prefix to a table.
    table_prefix: ?[]const u8 = null,

    /// The array of schema output for a given node.
    table_schema: ?[]const Option = null,

    /// The Amazon S3 path where temporary data can be staged when copying out of
    /// the database.
    temp_dir: ?[]const u8 = null,

    /// The action used on Redshift sinks when doing an APPEND.
    upsert: bool = false,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .action = "Action",
        .advanced_options = "AdvancedOptions",
        .catalog_database = "CatalogDatabase",
        .catalog_redshift_schema = "CatalogRedshiftSchema",
        .catalog_redshift_table = "CatalogRedshiftTable",
        .catalog_table = "CatalogTable",
        .connection = "Connection",
        .crawler_connection = "CrawlerConnection",
        .iam_role = "IamRole",
        .merge_action = "MergeAction",
        .merge_clause = "MergeClause",
        .merge_when_matched = "MergeWhenMatched",
        .merge_when_not_matched = "MergeWhenNotMatched",
        .post_action = "PostAction",
        .pre_action = "PreAction",
        .sample_query = "SampleQuery",
        .schema = "Schema",
        .selected_columns = "SelectedColumns",
        .source_type = "SourceType",
        .staging_table = "StagingTable",
        .table = "Table",
        .table_prefix = "TablePrefix",
        .table_schema = "TableSchema",
        .temp_dir = "TempDir",
        .upsert = "Upsert",
    };
};
