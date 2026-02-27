/// Configuration details for a CloudWatch Logs data source that can be used for
/// direct
/// queries.
pub const CloudWatchDirectQueryDataSource = struct {
    /// The unique identifier of the IAM role that grants OpenSearch Service
    /// permission to
    /// access the specified data source.
    role_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
    };
};
