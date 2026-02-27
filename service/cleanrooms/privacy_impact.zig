const DifferentialPrivacyPrivacyImpact = @import("differential_privacy_privacy_impact.zig").DifferentialPrivacyPrivacyImpact;

/// Provides an estimate of the number of aggregation functions that the member
/// who can query can run given the epsilon and noise parameters.
pub const PrivacyImpact = union(enum) {
    /// An object that lists the number and type of aggregation functions you can
    /// perform.
    differential_privacy: ?DifferentialPrivacyPrivacyImpact,

    pub const json_field_names = .{
        .differential_privacy = "differentialPrivacy",
    };
};
