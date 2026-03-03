const GrammarSlotTypeSetting = @import("grammar_slot_type_setting.zig").GrammarSlotTypeSetting;

/// Provides information about the external source of the slot type's
/// definition.
pub const ExternalSourceSetting = struct {
    /// Settings required for a slot type based on a grammar that you provide.
    grammar_slot_type_setting: ?GrammarSlotTypeSetting = null,

    pub const json_field_names = .{
        .grammar_slot_type_setting = "grammarSlotTypeSetting",
    };
};
