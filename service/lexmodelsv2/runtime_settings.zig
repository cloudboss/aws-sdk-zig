const NluImprovementSpecification = @import("nlu_improvement_specification.zig").NluImprovementSpecification;
const SlotResolutionImprovementSpecification = @import("slot_resolution_improvement_specification.zig").SlotResolutionImprovementSpecification;

/// Contains specifications about the Amazon Lex runtime generative AI
/// capabilities from Amazon Bedrock that you can turn on for your bot.
pub const RuntimeSettings = struct {
    /// An object containing specifications for the Assisted NLU feature within the
    /// bot's runtime settings. These settings determine how the bot processes and
    /// interprets user utterances during conversations.
    nlu_improvement: ?NluImprovementSpecification = null,

    /// An object containing specifications for the assisted slot resolution
    /// feature.
    slot_resolution_improvement: ?SlotResolutionImprovementSpecification = null,

    pub const json_field_names = .{
        .nlu_improvement = "nluImprovement",
        .slot_resolution_improvement = "slotResolutionImprovement",
    };
};
