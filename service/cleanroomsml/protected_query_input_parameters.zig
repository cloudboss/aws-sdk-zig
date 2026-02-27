const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const ResultFormat = @import("result_format.zig").ResultFormat;
const ProtectedQuerySQLParameters = @import("protected_query_sql_parameters.zig").ProtectedQuerySQLParameters;

/// Provides information necessary to perform the protected query.
pub const ProtectedQueryInputParameters = struct {
    /// Provides configuration information for the workers that will perform the
    /// protected query.
    compute_configuration: ?ComputeConfiguration,

    /// The format in which the query results should be returned. If not specified,
    /// defaults to `CSV`.
    result_format: ResultFormat = "CSV",

    sql_parameters: ProtectedQuerySQLParameters,

    pub const json_field_names = .{
        .compute_configuration = "computeConfiguration",
        .result_format = "resultFormat",
        .sql_parameters = "sqlParameters",
    };
};
