pub const FraudDetectionReason = enum {
    known_fraudster,
    voice_spoofing,

    pub const json_field_names = .{
        .known_fraudster = "KNOWN_FRAUDSTER",
        .voice_spoofing = "VOICE_SPOOFING",
    };
};
