const MembershipInferenceAttackScore = @import("membership_inference_attack_score.zig").MembershipInferenceAttackScore;

/// Privacy evaluation scores that measure the privacy characteristics of the
/// generated synthetic data, including assessments of potential privacy risks
/// such as membership inference attacks.
pub const DataPrivacyScores = struct {
    /// Scores that evaluate the vulnerability of the synthetic data to membership
    /// inference attacks, which attempt to determine whether a specific individual
    /// was a member of the original dataset.
    membership_inference_attack_scores: []const MembershipInferenceAttackScore,

    pub const json_field_names = .{
        .membership_inference_attack_scores = "membershipInferenceAttackScores",
    };
};
