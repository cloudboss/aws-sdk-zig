const PopulationAnalysisSqlParameters = @import("population_analysis_sql_parameters.zig").PopulationAnalysisSqlParameters;

/// Contains the configuration that defines the analysis used to populate an
/// intermediate table.
pub const PopulationAnalysisConfiguration = union(enum) {
    /// The SQL parameters for the population analysis, including the query string
    /// or analysis template ARN.
    sql_parameters: ?PopulationAnalysisSqlParameters,

    pub const json_field_names = .{
        .sql_parameters = "sqlParameters",
    };
};
