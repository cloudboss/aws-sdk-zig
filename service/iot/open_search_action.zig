/// Describes an action that writes data to an Amazon OpenSearch Service
/// domain.
pub const OpenSearchAction = struct {
    /// The endpoint of your OpenSearch domain.
    endpoint: []const u8,

    /// The unique identifier for the document you are storing.
    id: []const u8,

    /// The OpenSearch index where you want to store your data.
    index: []const u8,

    /// The IAM role ARN that has access to OpenSearch.
    role_arn: []const u8,

    /// The type of document you are storing.
    @"type": []const u8,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .id = "id",
        .index = "index",
        .role_arn = "roleArn",
        .@"type" = "type",
    };
};
