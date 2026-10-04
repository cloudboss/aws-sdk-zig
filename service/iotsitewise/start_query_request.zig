pub const StartQueryRequest = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The SQL query to execute against the workspace telemetry, annotations, data
    /// segment, and dataset data.
    query_statement: []const u8,

    /// The name of the workspace to query.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .query_statement = "queryStatement",
        .workspace_name = "workspaceName",
    };
};
