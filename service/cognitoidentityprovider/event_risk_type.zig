const RiskDecisionType = @import("risk_decision_type.zig").RiskDecisionType;
const RiskLevelType = @import("risk_level_type.zig").RiskLevelType;

/// The risk evaluation by adaptive authentication, as displayed in an
/// `AdminListUserAuthEvents` response. Contains evaluations of
/// compromised-credentials detection and assessed risk level and action taken
/// by adaptive
/// authentication.
pub const EventRiskType = struct {
    /// Indicates whether compromised credentials were detected during an
    /// authentication
    /// event.
    compromised_credentials_detected: ?bool = null,

    /// The action taken by adaptive authentication. If `NoRisk`, your user pool
    /// took no action. If `AccountTakeover`, your user pool applied the adaptive
    /// authentication automated response that you configured. If `Block`, your user
    /// pool prevented the attempt.
    risk_decision: ?RiskDecisionType = null,

    /// The risk level that adaptive authentication assessed for the authentication
    /// event.
    risk_level: ?RiskLevelType = null,

    pub const json_field_names = .{
        .compromised_credentials_detected = "CompromisedCredentialsDetected",
        .risk_decision = "RiskDecision",
        .risk_level = "RiskLevel",
    };
};
