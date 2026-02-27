/// Summary information about a vector index.
pub const IndexSummary = struct {
    /// Date and time when the vector index was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the vector index.
    index_arn: []const u8,

    /// The name of the vector index.
    index_name: []const u8,

    /// The name of the vector bucket that contains the vector index.
    vector_bucket_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .index_arn = "indexArn",
        .index_name = "indexName",
        .vector_bucket_name = "vectorBucketName",
    };
};
