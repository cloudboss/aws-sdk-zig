/// Q Connect integration config
pub const QConnectIntegrationConfig = struct {
    knowledge_base_arn: []const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
    };
};
