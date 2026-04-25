/// Configuration details for a Prometheus data source that can be used for
/// direct queries.
pub const PrometheusDirectQueryDataSource = struct {
    /// The unique identifier of the IAM role that grants OpenSearch Service
    /// permission to access
    /// the specified data source.
    role_arn: []const u8,

    /// The unique identifier of the Amazon Managed Prometheus Workspace that is
    /// associated with the specified
    /// data source.
    workspace_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .workspace_arn = "WorkspaceArn",
    };
};
