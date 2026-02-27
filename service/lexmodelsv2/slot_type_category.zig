pub const SlotTypeCategory = enum {
    custom,
    extended,
    external_grammar,
    composite,

    pub const json_field_names = .{
        .custom = "Custom",
        .extended = "Extended",
        .external_grammar = "ExternalGrammar",
        .composite = "Composite",
    };
};
