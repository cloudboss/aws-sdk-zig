/// Contains the SQL parameters used to populate an intermediate table.
pub const PopulationAnalysisSqlParameters = struct {
    /// The Amazon Resource Name (ARN) of the analysis template to use for
    /// populating the intermediate table.
    analysis_template_arn: ?[]const u8 = null,

    /// The SQL query string used to populate the intermediate table.
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_template_arn = "analysisTemplateArn",
        .query_string = "queryString",
    };
};
