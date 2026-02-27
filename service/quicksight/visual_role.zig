pub const VisualRole = enum {
    primary,
    complimentary,
    multi_intent,
    fallback,
    fragment,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .complimentary = "COMPLIMENTARY",
        .multi_intent = "MULTI_INTENT",
        .fallback = "FALLBACK",
        .fragment = "FRAGMENT",
    };
};
