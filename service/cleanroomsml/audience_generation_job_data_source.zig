const S3ConfigMap = @import("s3_config_map.zig").S3ConfigMap;
const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const ProtectedQuerySQLParameters = @import("protected_query_sql_parameters.zig").ProtectedQuerySQLParameters;

/// Defines the Amazon S3 bucket where the seed audience for the generating
/// audience is stored.
pub const AudienceGenerationJobDataSource = struct {
    /// Defines the Amazon S3 bucket where the seed audience for the generating
    /// audience is stored. A valid data source is a JSON line file in the following
    /// format:
    ///
    /// `{"user_id": "111111"}`
    ///
    /// `{"user_id": "222222"}`
    ///
    /// `...`
    data_source: ?S3ConfigMap,

    /// The ARN of the IAM role that can read the Amazon S3 bucket where the seed
    /// audience is stored.
    role_arn: []const u8,

    sql_compute_configuration: ?ComputeConfiguration,

    /// The protected SQL query parameters.
    sql_parameters: ?ProtectedQuerySQLParameters,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .role_arn = "roleArn",
        .sql_compute_configuration = "sqlComputeConfiguration",
        .sql_parameters = "sqlParameters",
    };
};
