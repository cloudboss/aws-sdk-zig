pub const SalesInvolvementType = enum {
    for_visibility_only,
    co_sell,

    pub const json_field_names = .{
        .for_visibility_only = "FOR_VISIBILITY_ONLY",
        .co_sell = "CO_SELL",
    };
};
