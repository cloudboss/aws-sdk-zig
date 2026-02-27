const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const DifferentialPrivacyParameters = @import("differential_privacy_parameters.zig").DifferentialPrivacyParameters;
const ProtectedQueryError = @import("protected_query_error.zig").ProtectedQueryError;
const ProtectedQueryResult = @import("protected_query_result.zig").ProtectedQueryResult;
const ProtectedQueryResultConfiguration = @import("protected_query_result_configuration.zig").ProtectedQueryResultConfiguration;
const ProtectedQuerySQLParameters = @import("protected_query_sql_parameters.zig").ProtectedQuerySQLParameters;
const ProtectedQueryStatistics = @import("protected_query_statistics.zig").ProtectedQueryStatistics;
const ProtectedQueryStatus = @import("protected_query_status.zig").ProtectedQueryStatus;

/// The parameters for an Clean Rooms protected query.
pub const ProtectedQuery = struct {
    /// The compute configuration for the protected query.
    compute_configuration: ?ComputeConfiguration,

    /// The time at which the protected query was created.
    create_time: i64,

    /// The sensitivity parameters of the differential privacy results of the
    /// protected query.
    differential_privacy: ?DifferentialPrivacyParameters,

    /// An error thrown by the protected query.
    @"error": ?ProtectedQueryError,

    /// The identifier for a protected query instance.
    id: []const u8,

    /// The ARN of the membership.
    membership_arn: []const u8,

    /// The identifier for the membership.
    membership_id: []const u8,

    /// The result of the protected query.
    result: ?ProtectedQueryResult,

    /// Contains any details needed to write the query results.
    result_configuration: ?ProtectedQueryResultConfiguration,

    /// The protected query SQL parameters.
    sql_parameters: ?ProtectedQuerySQLParameters,

    /// Statistics about protected query execution.
    statistics: ?ProtectedQueryStatistics,

    /// The status of the query.
    status: ProtectedQueryStatus,

    pub const json_field_names = .{
        .compute_configuration = "computeConfiguration",
        .create_time = "createTime",
        .differential_privacy = "differentialPrivacy",
        .@"error" = "error",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .result = "result",
        .result_configuration = "resultConfiguration",
        .sql_parameters = "sqlParameters",
        .statistics = "statistics",
        .status = "status",
    };
};
