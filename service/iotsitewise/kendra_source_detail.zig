/// The source details for the Kendra dataset source.
pub const KendraSourceDetail = struct {
    /// The `knowledgeBaseArn` details for the Kendra dataset source.
    knowledge_base_arn: []const u8,

    /// The `roleARN` details for the Kendra dataset source.
    role_arn: []const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
        .role_arn = "roleArn",
    };
};
