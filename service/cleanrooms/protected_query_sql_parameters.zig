const aws = @import("aws");

/// The parameters for the SQL type Protected Query.
pub const ProtectedQuerySQLParameters = struct {
    /// The Amazon Resource Name (ARN) associated with the analysis template within
    /// a collaboration.
    analysis_template_arn: ?[]const u8,

    /// The protected query SQL parameters.
    parameters: ?[]const aws.map.StringMapEntry,

    /// The query string to be submitted.
    query_string: ?[]const u8,

    pub const json_field_names = .{
        .analysis_template_arn = "analysisTemplateArn",
        .parameters = "parameters",
        .query_string = "queryString",
    };
};
