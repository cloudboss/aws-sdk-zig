/// The connection parameters for a fully managed knowledge base data source.
/// Provide these parameters in the `DataSourceParameters` object when you
/// create or update a data source that uses a fully managed knowledge base.
pub const FMKBParameters = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Bedrock knowledge base.
    knowledge_base_arn: []const u8,

    /// The IDs of the linked data sources.
    linked_data_source_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .knowledge_base_arn = "KnowledgeBaseArn",
        .linked_data_source_ids = "LinkedDataSourceIds",
    };
};
