const DescriptiveBotBuilderSpecification = @import("descriptive_bot_builder_specification.zig").DescriptiveBotBuilderSpecification;
const SampleUtteranceGenerationSpecification = @import("sample_utterance_generation_specification.zig").SampleUtteranceGenerationSpecification;

/// Contains specifications about the Amazon Lex build time generative AI
/// capabilities from Amazon Bedrock that you can turn on for your bot.
pub const BuildtimeSettings = struct {
    /// An object containing specifications for the descriptive bot building
    /// feature.
    descriptive_bot_builder: ?DescriptiveBotBuilderSpecification,

    /// Contains specifications for the sample utterance generation feature.
    sample_utterance_generation: ?SampleUtteranceGenerationSpecification,

    pub const json_field_names = .{
        .descriptive_bot_builder = "descriptiveBotBuilder",
        .sample_utterance_generation = "sampleUtteranceGeneration",
    };
};
