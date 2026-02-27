const RetrieveAndGenerateConfiguration = @import("retrieve_and_generate_configuration.zig").RetrieveAndGenerateConfiguration;
const RetrieveConfig = @import("retrieve_config.zig").RetrieveConfig;

/// The configuration details for retrieving information from a knowledge base
/// and generating responses.
pub const KnowledgeBaseConfig = union(enum) {
    /// Contains configuration details for retrieving information from a knowledge
    /// base and generating responses.
    retrieve_and_generate_config: ?RetrieveAndGenerateConfiguration,
    /// Contains configuration details for retrieving information from a knowledge
    /// base.
    retrieve_config: ?RetrieveConfig,

    pub const json_field_names = .{
        .retrieve_and_generate_config = "retrieveAndGenerateConfig",
        .retrieve_config = "retrieveConfig",
    };
};
