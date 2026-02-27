/// Settings for an Amazon Kendra knowledge base.
pub const KendraKnowledgeBaseConfiguration = struct {
    /// The ARN of the Amazon Kendra index.
    kendra_index_arn: []const u8,

    pub const json_field_names = .{
        .kendra_index_arn = "kendraIndexArn",
    };
};
