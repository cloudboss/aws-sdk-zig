const KnownFraudsterRisk = @import("known_fraudster_risk.zig").KnownFraudsterRisk;
const VoiceSpoofingRisk = @import("voice_spoofing_risk.zig").VoiceSpoofingRisk;

/// Details regarding various fraud risk analyses performed against the current
/// session
/// state and streamed audio of the speaker.
pub const FraudRiskDetails = struct {
    /// The details resulting from 'Known Fraudster Risk' analysis of the speaker.
    known_fraudster_risk: KnownFraudsterRisk,

    /// The details resulting from 'Voice Spoofing Risk' analysis of the speaker.
    voice_spoofing_risk: VoiceSpoofingRisk,

    pub const json_field_names = .{
        .known_fraudster_risk = "KnownFraudsterRisk",
        .voice_spoofing_risk = "VoiceSpoofingRisk",
    };
};
