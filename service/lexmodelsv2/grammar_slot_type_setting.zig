const GrammarSlotTypeSource = @import("grammar_slot_type_source.zig").GrammarSlotTypeSource;

/// Settings requried for a slot type based on a grammar that you provide.
pub const GrammarSlotTypeSetting = struct {
    /// The source of the grammar used to create the slot type.
    source: ?GrammarSlotTypeSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
