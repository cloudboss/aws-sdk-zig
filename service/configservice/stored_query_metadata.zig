/// Returns details of a specific query.
pub const StoredQueryMetadata = struct {
    /// A unique description for the query.
    description: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the query. For example,
    /// arn:partition:service:region:account-id:resource-type/resource-name/resource-id.
    query_arn: []const u8,

    /// The ID of the query.
    query_id: []const u8,

    /// The name of the query.
    query_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .query_arn = "QueryArn",
        .query_id = "QueryId",
        .query_name = "QueryName",
    };
};
