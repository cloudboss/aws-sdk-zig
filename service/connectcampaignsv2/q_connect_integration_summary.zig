/// Q Connect integration summary
pub const QConnectIntegrationSummary = struct {
    knowledge_base_arn: []const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
    };
};
