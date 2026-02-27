pub const ICD10CMTraitName = enum {
    negation,
    diagnosis,
    sign,
    symptom,
    pertains_to_family,
    hypothetical,
    low_confidence,

    pub const json_field_names = .{
        .negation = "NEGATION",
        .diagnosis = "DIAGNOSIS",
        .sign = "SIGN",
        .symptom = "SYMPTOM",
        .pertains_to_family = "PERTAINS_TO_FAMILY",
        .hypothetical = "HYPOTHETICAL",
        .low_confidence = "LOW_CONFIDENCE",
    };
};
