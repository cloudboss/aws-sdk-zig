/// Contains details produced as a result of performing known fraudster risk
/// analysis on a
/// speaker.
pub const KnownFraudsterRisk = struct {
    /// The identifier of the fraudster that is the closest match to the speaker. If
    /// there are
    /// no fraudsters registered in a given domain, or if there are no fraudsters
    /// with a
    /// non-zero RiskScore, this value is `null`.
    generated_fraudster_id: ?[]const u8 = null,

    /// The score indicating the likelihood the speaker is a known fraudster.
    risk_score: i32,

    pub const json_field_names = .{
        .generated_fraudster_id = "GeneratedFraudsterId",
        .risk_score = "RiskScore",
    };
};
