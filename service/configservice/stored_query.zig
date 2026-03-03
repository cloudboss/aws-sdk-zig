/// Provides the details of a stored query.
pub const StoredQuery = struct {
    /// A unique description for the query.
    description: ?[]const u8 = null,

    /// The expression of the query. For example, `SELECT
    /// resourceId,
    /// resourceType,
    /// supplementaryConfiguration.BucketVersioningConfiguration.status
    /// WHERE
    /// resourceType = 'AWS::S3::Bucket'
    /// AND supplementaryConfiguration.BucketVersioningConfiguration.status =
    /// 'Off'.`
    expression: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the query. For example,
    /// arn:partition:service:region:account-id:resource-type/resource-name/resource-id.
    query_arn: ?[]const u8 = null,

    /// The ID of the query.
    query_id: ?[]const u8 = null,

    /// The name of the query.
    query_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .expression = "Expression",
        .query_arn = "QueryArn",
        .query_id = "QueryId",
        .query_name = "QueryName",
    };
};
