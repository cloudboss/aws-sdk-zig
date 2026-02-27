const aws = @import("aws");

const RuntimeHintValue = @import("runtime_hint_value.zig").RuntimeHintValue;

/// Provides an array of phrases that should be given preference when
/// resolving values for a slot.
pub const RuntimeHintDetails = struct {
    /// One or more strings that Amazon Lex V2 should look for in the input to the
    /// bot. Each phrase is given preference when deciding on slot
    /// values.
    runtime_hint_values: ?[]const RuntimeHintValue,

    /// A map of constituent sub slot names inside a composite slot in the intent
    /// and the phrases
    /// that should be added for each sub slot. Inside each composite slot hints,
    /// this structure provides
    /// a mechanism to add granular sub slot phrases. Only sub slot hints are
    /// supported for composite slots.
    /// The intent name, composite slot name and the constituent sub slot names must
    /// exist.
    sub_slot_hints: ?[]const aws.map.MapEntry(RuntimeHintDetails),

    pub const json_field_names = .{
        .runtime_hint_values = "runtimeHintValues",
        .sub_slot_hints = "subSlotHints",
    };
};
