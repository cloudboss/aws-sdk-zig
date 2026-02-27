const CustomMemoryStrategyInput = @import("custom_memory_strategy_input.zig").CustomMemoryStrategyInput;
const EpisodicMemoryStrategyInput = @import("episodic_memory_strategy_input.zig").EpisodicMemoryStrategyInput;
const SemanticMemoryStrategyInput = @import("semantic_memory_strategy_input.zig").SemanticMemoryStrategyInput;
const SummaryMemoryStrategyInput = @import("summary_memory_strategy_input.zig").SummaryMemoryStrategyInput;
const UserPreferenceMemoryStrategyInput = @import("user_preference_memory_strategy_input.zig").UserPreferenceMemoryStrategyInput;

/// Contains input information for creating a memory strategy.
pub const MemoryStrategyInput = union(enum) {
    /// Input for creating a custom memory strategy.
    custom_memory_strategy: ?CustomMemoryStrategyInput,
    /// Input for creating an episodic memory strategy
    episodic_memory_strategy: ?EpisodicMemoryStrategyInput,
    /// Input for creating a semantic memory strategy.
    semantic_memory_strategy: ?SemanticMemoryStrategyInput,
    /// Input for creating a summary memory strategy.
    summary_memory_strategy: ?SummaryMemoryStrategyInput,
    /// Input for creating a user preference memory strategy.
    user_preference_memory_strategy: ?UserPreferenceMemoryStrategyInput,

    pub const json_field_names = .{
        .custom_memory_strategy = "customMemoryStrategy",
        .episodic_memory_strategy = "episodicMemoryStrategy",
        .semantic_memory_strategy = "semanticMemoryStrategy",
        .summary_memory_strategy = "summaryMemoryStrategy",
        .user_preference_memory_strategy = "userPreferenceMemoryStrategy",
    };
};
