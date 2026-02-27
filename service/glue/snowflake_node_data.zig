const aws = @import("aws");

const Option = @import("option.zig").Option;

/// Specifies configuration for Snowflake nodes in Glue Studio.
pub const SnowflakeNodeData = struct {
    /// Specifies what action to take when writing to a table with preexisting data.
    /// Valid values: `
    /// append`, `merge`, `truncate`, `drop`.
    action: ?[]const u8,

    /// Specifies additional options passed to the Snowflake connector. If options
    /// are specified
    /// elsewhere in this node, this will take precedence.
    additional_options: ?[]const aws.map.StringMapEntry,

    /// Specifies whether automatic query pushdown is enabled. If pushdown
    /// is enabled, then when a query is run on Spark, if part of the query can be
    /// "pushed down" to
    /// the
    /// Snowflake server, it is pushed down. This improves performance of some
    /// queries.
    auto_pushdown: bool = false,

    /// Specifies a Glue Data Catalog Connection to a Snowflake endpoint.
    connection: ?Option,

    /// Specifies a Snowflake database for your node to use.
    database: ?[]const u8,

    /// Not currently used.
    iam_role: ?Option,

    /// Specifies a merge action. Valid values: `simple`, `custom`. If
    /// simple, merge behavior is defined by `MergeWhenMatched` and `
    /// MergeWhenNotMatched`. If custom, defined by `MergeClause`.
    merge_action: ?[]const u8,

    /// A SQL statement that specifies a custom merge behavior.
    merge_clause: ?[]const u8,

    /// Specifies how to resolve records that match preexisting data when merging.
    /// Valid values: `
    /// update`, `delete`.
    merge_when_matched: ?[]const u8,

    /// Specifies how to process records that do not match preexisting data when
    /// merging. Valid
    /// values: `insert`, `none`.
    merge_when_not_matched: ?[]const u8,

    /// A SQL string run after the Snowflake connector performs its standard
    /// actions.
    post_action: ?[]const u8,

    /// A SQL string run before the Snowflake connector performs its standard
    /// actions.
    pre_action: ?[]const u8,

    /// A SQL string used to retrieve data with the `query` sourcetype.
    sample_query: ?[]const u8,

    /// Specifies a Snowflake database schema for your node to use.
    schema: ?[]const u8,

    /// Specifies the columns combined to identify a record when detecting matches
    /// for merges and
    /// upserts. A list of structures with `value`, `label` and `
    /// description` keys. Each structure describes a column.
    selected_columns: ?[]const Option,

    /// Specifies how retrieved data is specified. Valid values: `"table"`, `
    /// "query"`.
    source_type: ?[]const u8,

    /// The name of a staging table used when performing `merge` or upsert `append`
    /// actions. Data is written to this table, then moved to `table` by a generated
    /// postaction.
    staging_table: ?[]const u8,

    /// Specifies a Snowflake table for your node to use.
    table: ?[]const u8,

    /// Manually defines the target schema for the node. A list of structures with
    /// `value`
    /// , `label` and `description` keys. Each structure defines a column.
    table_schema: ?[]const Option,

    /// Not currently used.
    temp_dir: ?[]const u8,

    /// Used when Action is `append`. Specifies the resolution behavior when a row
    /// already exists. If true, preexisting rows will be updated. If false, those
    /// rows will be inserted.
    upsert: bool = false,

    pub const json_field_names = .{
        .action = "Action",
        .additional_options = "AdditionalOptions",
        .auto_pushdown = "AutoPushdown",
        .connection = "Connection",
        .database = "Database",
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
        .table_schema = "TableSchema",
        .temp_dir = "TempDir",
        .upsert = "Upsert",
    };
};
