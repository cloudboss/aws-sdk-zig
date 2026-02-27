pub const ContextType = enum {
    causal,
    contextual,

    pub const json_field_names = .{
        .causal = "CAUSAL",
        .contextual = "CONTEXTUAL",
    };
};
