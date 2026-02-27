pub const RxNormTraitName = enum {
    negation,
    past_history,

    pub const json_field_names = .{
        .negation = "NEGATION",
        .past_history = "PAST_HISTORY",
    };
};
