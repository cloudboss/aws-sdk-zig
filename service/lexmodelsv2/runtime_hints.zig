const aws = @import("aws");

const RuntimeHintDetails = @import("runtime_hint_details.zig").RuntimeHintDetails;

/// You can provide Amazon Lex with hints to the phrases that a customer is
/// likely to use for a slot. When a slot with hints is resolved, the
/// phrases in the runtime hints are preferred in the resolution. You can
/// provide hints for a maximum of 100 intents. You can provide a maximum
/// of 100 slots.
///
/// Before you can use runtime hints with an existing bot, you must
/// first rebuild the bot.
///
/// For more information, see [Using runtime hints to
/// improve recognition of slot
/// values](https://docs.aws.amazon.com/lexv2/latest/dg/using-hints.html).
pub const RuntimeHints = struct {
    /// A list of the slots in the intent that should have runtime hints
    /// added, and the phrases that should be added for each slot.
    ///
    /// The first level of the `slotHints` map is the name of the
    /// intent. The second level is the name of the slot within the intent. For
    /// more information, see [Using hints to improve
    /// accuracy](https://docs.aws.amazon.com/lexv2/latest/dg/using-hints.html).
    ///
    /// The intent name and slot name must exist.
    slot_hints: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(RuntimeHintDetails)),

    pub const json_field_names = .{
        .slot_hints = "slotHints",
    };
};
