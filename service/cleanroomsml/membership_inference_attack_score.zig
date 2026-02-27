const MembershipInferenceAttackVersion = @import("membership_inference_attack_version.zig").MembershipInferenceAttackVersion;

/// A score that measures the vulnerability of synthetic data to membership
/// inference attacks and provides both the numerical score and the version of
/// the attack methodology used for evaluation.
pub const MembershipInferenceAttackScore = struct {
    /// The version of the membership inference attack, which consists of the attack
    /// type and its version number, used to generate this privacy score.
    attack_version: MembershipInferenceAttackVersion,

    /// The numerical score representing the vulnerability to membership inference
    /// attacks.
    score: f64,

    pub const json_field_names = .{
        .attack_version = "attackVersion",
        .score = "score",
    };
};
