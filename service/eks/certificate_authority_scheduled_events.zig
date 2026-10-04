/// The scheduled events during which Amazon EKS may automatically activate a
/// certificate
/// authority, computed from its validity period. These events help ensure that
/// a cluster's
/// signing certificate authority is rotated before its certificate expires.
pub const CertificateAuthorityScheduledEvents = struct {
    /// The Unix epoch timestamp in seconds by which Amazon EKS will automatically
    /// activate this
    /// certificate authority if you haven't already activated it.
    final_auto_activation: ?i64 = null,

    /// The earliest Unix epoch timestamp in seconds at which Amazon EKS may
    /// automatically activate
    /// this certificate authority.
    first_auto_activation: ?i64 = null,

    pub const json_field_names = .{
        .final_auto_activation = "finalAutoActivation",
        .first_auto_activation = "firstAutoActivation",
    };
};
