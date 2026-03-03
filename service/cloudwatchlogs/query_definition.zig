const QueryLanguage = @import("query_language.zig").QueryLanguage;

/// This structure contains details about a saved CloudWatch Logs Insights query
/// definition.
pub const QueryDefinition = struct {
    /// The date that the query definition was most recently modified.
    last_modified: ?i64 = null,

    /// If this query definition contains a list of log groups that it is limited
    /// to, that list
    /// appears here.
    log_group_names: ?[]const []const u8 = null,

    /// The name of the query definition.
    name: ?[]const u8 = null,

    /// The unique ID of the query definition.
    query_definition_id: ?[]const u8 = null,

    /// The query language used for this query. For more information about the query
    /// languages
    /// that CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    /// The query string to use for this definition. For more information, see
    /// [CloudWatch Logs
    /// Insights Query
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modified = "lastModified",
        .log_group_names = "logGroupNames",
        .name = "name",
        .query_definition_id = "queryDefinitionId",
        .query_language = "queryLanguage",
        .query_string = "queryString",
    };
};
