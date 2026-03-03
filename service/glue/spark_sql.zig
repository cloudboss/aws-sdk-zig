const GlueSchema = @import("glue_schema.zig").GlueSchema;
const SqlAlias = @import("sql_alias.zig").SqlAlias;

/// Specifies a transform where you enter a SQL query using Spark SQL syntax to
/// transform the data. The output is a single `DynamicFrame`.
pub const SparkSQL = struct {
    /// The data inputs identified by their node names. You can associate a table
    /// name with each input node to use in the SQL query. The name you choose must
    /// meet the Spark SQL naming restrictions.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// Specifies the data schema for the SparkSQL transform.
    output_schemas: ?[]const GlueSchema = null,

    /// A list of aliases. An alias allows you to specify what name to use in the
    /// SQL for a given input. For example, you have a datasource named
    /// "MyDataSource". If you specify `From` as MyDataSource, and `Alias` as
    /// SqlName, then in your SQL you can do:
    ///
    /// `select *
    /// from SqlName`
    ///
    /// and that gets data from MyDataSource.
    sql_aliases: []const SqlAlias,

    /// A SQL query that must use Spark SQL syntax and return a single data set.
    sql_query: []const u8,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .sql_aliases = "SqlAliases",
        .sql_query = "SqlQuery",
    };
};
