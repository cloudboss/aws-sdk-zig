/// Describes an action that writes data to an Amazon OpenSearch Service
/// domain.
///
/// The `Elasticsearch` action can only be used by existing rule actions. To
/// create a
/// new rule action or to update an existing rule action, use the
/// `OpenSearch` rule action instead. For more information, see
/// [OpenSearchAction](https://docs.aws.amazon.com/iot/latest/apireference/API_OpenSearchAction.html).
pub const ElasticsearchAction = struct {
    /// The endpoint of your OpenSearch domain.
    endpoint: []const u8,

    /// The unique identifier for the document you are storing.
    id: []const u8,

    /// The index where you want to store your data.
    index: []const u8,

    /// The IAM role ARN that has access to OpenSearch.
    role_arn: []const u8,

    /// The type of document you are storing.
    type: []const u8,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .id = "id",
        .index = "index",
        .role_arn = "roleArn",
        .type = "type",
    };
};
