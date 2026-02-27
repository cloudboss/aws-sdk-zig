const FraudDetectionConfiguration = @import("fraud_detection_configuration.zig").FraudDetectionConfiguration;
const FraudDetectionDecision = @import("fraud_detection_decision.zig").FraudDetectionDecision;
const FraudDetectionReason = @import("fraud_detection_reason.zig").FraudDetectionReason;
const FraudRiskDetails = @import("fraud_risk_details.zig").FraudRiskDetails;

/// The fraud detection result produced by Voice ID, processed against the
/// current
/// session state and streamed audio of the speaker.
pub const FraudDetectionResult = struct {
    /// A timestamp of when audio aggregation ended for this fraud detection
    /// result.
    audio_aggregation_ended_at: ?i64,

    /// A timestamp of when audio aggregation started for this fraud detection
    /// result.
    audio_aggregation_started_at: ?i64,

    /// The `FraudDetectionConfiguration` used to generate this fraud detection
    /// result.
    configuration: ?FraudDetectionConfiguration,

    /// The fraud detection decision produced by Voice ID, processed against the
    /// current
    /// session state and streamed audio of the speaker.
    decision: ?FraudDetectionDecision,

    /// The unique identifier for this fraud detection result. Given there can be
    /// multiple
    /// fraud detections for a given session, this field helps in identifying if the
    /// returned
    /// result is from previous streaming activity or a new result. Note that in the
    /// absence of
    /// any new streaming activity or risk threshold changes, Voice ID always
    /// returns cached
    /// Fraud Detection result for this API.
    fraud_detection_result_id: ?[]const u8,

    /// The reason speaker was flagged by the fraud detection system. This is only
    /// be
    /// populated if fraud detection Decision is `HIGH_RISK`, and the following
    /// possible values: `KNOWN_FRAUDSTER` and `VOICE_SPOOFING`.
    reasons: ?[]const FraudDetectionReason,

    /// Details about each risk analyzed for this speaker. Currently, this contains
    /// KnownFraudsterRisk and VoiceSpoofingRisk details.
    risk_details: ?FraudRiskDetails,

    pub const json_field_names = .{
        .audio_aggregation_ended_at = "AudioAggregationEndedAt",
        .audio_aggregation_started_at = "AudioAggregationStartedAt",
        .configuration = "Configuration",
        .decision = "Decision",
        .fraud_detection_result_id = "FraudDetectionResultId",
        .reasons = "Reasons",
        .risk_details = "RiskDetails",
    };
};
