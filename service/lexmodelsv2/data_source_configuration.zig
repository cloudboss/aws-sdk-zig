const BedrockKnowledgeStoreConfiguration = @import("bedrock_knowledge_store_configuration.zig").BedrockKnowledgeStoreConfiguration;
const QnAKendraConfiguration = @import("qn_a_kendra_configuration.zig").QnAKendraConfiguration;
const OpensearchConfiguration = @import("opensearch_configuration.zig").OpensearchConfiguration;

/// Contains details about the configuration of the knowledge store used for the
/// `AMAZON.QnAIntent`. You must have already created the knowledge store and
/// indexed the documents within it.
pub const DataSourceConfiguration = struct {
    /// Contains details about the configuration of the Amazon Bedrock knowledge
    /// base used for the `AMAZON.QnAIntent`. To set up a knowledge base, follow the
    /// steps at [Building a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base.html).
    bedrock_knowledge_store_configuration: ?BedrockKnowledgeStoreConfiguration = null,

    /// Contains details about the configuration of the Amazon Kendra index used for
    /// the `AMAZON.QnAIntent`. To create a Amazon Kendra index, follow the steps at
    /// [Creating an
    /// index](https://docs.aws.amazon.com/kendra/latest/dg/create-index.html).
    kendra_configuration: ?QnAKendraConfiguration = null,

    /// Contains details about the configuration of the Amazon OpenSearch Service
    /// database used for the `AMAZON.QnAIntent`. To create a domain, follow the
    /// steps at [Creating and managing Amazon OpenSearch Service
    /// domains](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html).
    opensearch_configuration: ?OpensearchConfiguration = null,

    pub const json_field_names = .{
        .bedrock_knowledge_store_configuration = "bedrockKnowledgeStoreConfiguration",
        .kendra_configuration = "kendraConfiguration",
        .opensearch_configuration = "opensearchConfiguration",
    };
};
