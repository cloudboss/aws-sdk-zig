/// Contains the storage configuration of the knowledge base for S3 vectors.
pub const S3VectorsConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the vector index used for the knowledge
    /// base. This ARN identifies the specific vector index resource within Amazon
    /// Bedrock.
    index_arn: ?[]const u8,

    /// The name of the vector index used for the knowledge base. This name
    /// identifies the vector index within the Amazon Bedrock service.
    index_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the S3 bucket where vector embeddings are
    /// stored. This bucket contains the vector data used by the knowledge base.
    vector_bucket_arn: ?[]const u8,

    pub const json_field_names = .{
        .index_arn = "indexArn",
        .index_name = "indexName",
        .vector_bucket_arn = "vectorBucketArn",
    };
};
