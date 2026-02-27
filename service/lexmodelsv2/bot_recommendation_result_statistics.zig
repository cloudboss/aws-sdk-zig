const IntentStatistics = @import("intent_statistics.zig").IntentStatistics;
const SlotTypeStatistics = @import("slot_type_statistics.zig").SlotTypeStatistics;

/// A statistical summary of the bot recommendation results.
pub const BotRecommendationResultStatistics = struct {
    /// Statistical information about about the intents associated with the
    /// bot recommendation results.
    intents: ?IntentStatistics,

    /// Statistical information about the slot types associated with the bot
    /// recommendation results.
    slot_types: ?SlotTypeStatistics,

    pub const json_field_names = .{
        .intents = "intents",
        .slot_types = "slotTypes",
    };
};
