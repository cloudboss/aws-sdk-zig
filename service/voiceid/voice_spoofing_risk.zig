/// The details resulting from 'Voice Spoofing Risk' analysis of the speaker.
pub const VoiceSpoofingRisk = struct {
    /// The score indicating the likelihood of speaker’s voice being spoofed.
    risk_score: i32,

    pub const json_field_names = .{
        .risk_score = "RiskScore",
    };
};
