const SalesforceCustomKnowledgeArticleTypeConfiguration = @import("salesforce_custom_knowledge_article_type_configuration.zig").SalesforceCustomKnowledgeArticleTypeConfiguration;
const SalesforceKnowledgeArticleState = @import("salesforce_knowledge_article_state.zig").SalesforceKnowledgeArticleState;
const SalesforceStandardKnowledgeArticleTypeConfiguration = @import("salesforce_standard_knowledge_article_type_configuration.zig").SalesforceStandardKnowledgeArticleTypeConfiguration;

/// Provides the configuration information for the knowledge article types that
/// Amazon Kendra indexes. Amazon Kendra indexes standard knowledge articles and
/// the
/// standard fields of knowledge articles, or the custom fields of custom
/// knowledge
/// articles, but not both
pub const SalesforceKnowledgeArticleConfiguration = struct {
    /// Configuration information for custom Salesforce knowledge articles.
    custom_knowledge_article_type_configurations: ?[]const SalesforceCustomKnowledgeArticleTypeConfiguration,

    /// Specifies the document states that should be included when Amazon Kendra
    /// indexes
    /// knowledge articles. You must specify at least one state.
    included_states: []const SalesforceKnowledgeArticleState,

    /// Configuration information for standard Salesforce knowledge articles.
    standard_knowledge_article_type_configuration: ?SalesforceStandardKnowledgeArticleTypeConfiguration,

    pub const json_field_names = .{
        .custom_knowledge_article_type_configurations = "CustomKnowledgeArticleTypeConfigurations",
        .included_states = "IncludedStates",
        .standard_knowledge_article_type_configuration = "StandardKnowledgeArticleTypeConfiguration",
    };
};
