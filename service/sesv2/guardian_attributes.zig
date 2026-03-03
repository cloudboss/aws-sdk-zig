const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// An object containing additional settings for your VDM configuration as
/// applicable to
/// the Guardian.
pub const GuardianAttributes = struct {
    /// Specifies the status of your VDM optimized shared delivery. Can be one of
    /// the
    /// following:
    ///
    /// * `ENABLED` – Amazon SES enables optimized shared delivery for your
    /// account.
    ///
    /// * `DISABLED` – Amazon SES disables optimized shared delivery for
    /// your account.
    optimized_shared_delivery: ?FeatureStatus = null,

    pub const json_field_names = .{
        .optimized_shared_delivery = "OptimizedSharedDelivery",
    };
};
