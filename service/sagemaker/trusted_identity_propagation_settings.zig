const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The Trusted Identity Propagation (TIP) settings for the SageMaker domain.
/// These settings determine how user identities from IAM Identity Center are
/// propagated through the domain to TIP enabled Amazon Web Services services.
pub const TrustedIdentityPropagationSettings = struct {
    /// The status of Trusted Identity Propagation (TIP) at the SageMaker domain
    /// level.
    ///
    /// When disabled, standard IAM role-based access is used.
    ///
    /// When enabled:
    ///
    /// * User identities from IAM Identity Center are propagated through the
    ///   application to TIP enabled Amazon Web Services services.
    /// * New applications or existing applications that are automatically patched,
    ///   will use the domain level configuration.
    status: FeatureStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
