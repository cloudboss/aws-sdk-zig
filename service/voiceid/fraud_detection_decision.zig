pub const FraudDetectionDecision = enum {
    high_risk,
    low_risk,
    not_enough_speech,

    pub const json_field_names = .{
        .high_risk = "HIGH_RISK",
        .low_risk = "LOW_RISK",
        .not_enough_speech = "NOT_ENOUGH_SPEECH",
    };
};
