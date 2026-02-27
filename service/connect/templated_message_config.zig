const TemplateAttributes = @import("template_attributes.zig").TemplateAttributes;

/// Information about template message configuration.
pub const TemplatedMessageConfig = struct {
    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The identifier of the message template Id.
    message_template_id: []const u8,

    /// Information about template attributes, that is, CustomAttributes or
    /// CustomerProfileAttributes.
    template_attributes: TemplateAttributes,

    pub const json_field_names = .{
        .knowledge_base_id = "KnowledgeBaseId",
        .message_template_id = "MessageTemplateId",
        .template_attributes = "TemplateAttributes",
    };
};
