pub const AttributeName = enum {
    sign,
    symptom,
    diagnosis,
    negation,
    pertains_to_family,
    hypothetical,
    low_confidence,
    past_history,
    future,

    pub const json_field_names = .{
        .sign = "SIGN",
        .symptom = "SYMPTOM",
        .diagnosis = "DIAGNOSIS",
        .negation = "NEGATION",
        .pertains_to_family = "PERTAINS_TO_FAMILY",
        .hypothetical = "HYPOTHETICAL",
        .low_confidence = "LOW_CONFIDENCE",
        .past_history = "PAST_HISTORY",
        .future = "FUTURE",
    };
};
