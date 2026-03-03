const LoadBalancerTlsCertificateDomainValidationOption = @import("load_balancer_tls_certificate_domain_validation_option.zig").LoadBalancerTlsCertificateDomainValidationOption;
const LoadBalancerTlsCertificateRenewalStatus = @import("load_balancer_tls_certificate_renewal_status.zig").LoadBalancerTlsCertificateRenewalStatus;

/// Contains information about the status of Lightsail's managed renewal for the
/// certificate.
///
/// The renewal status of the certificate.
///
/// The following renewal status are possible:
///
/// * **
/// `PendingAutoRenewal`
/// ** - Lightsail is
/// attempting to automatically validate the domain names in the certificate. No
/// further
/// action is required.
///
/// * **
/// `PendingValidation`
/// ** - Lightsail couldn't
/// automatically validate one or more domain names in the certificate. You must
/// take action
/// to validate these domain names or the certificate won't be renewed. If you
/// used DNS
/// validation, check to make sure your certificate's domain validation records
/// exist in your
/// domain's DNS, and that your certificate remains in use.
///
/// * **
/// `Success`
/// ** - All domain names in the
/// certificate are validated, and Lightsail renewed the certificate. No further
/// action is
/// required.
///
/// * **
/// `Failed`
/// ** - One or more domain names were
/// not validated before the certificate expired, and Lightsail did not renew
/// the
/// certificate. You can request a new certificate using the `CreateCertificate`
/// action.
pub const LoadBalancerTlsCertificateRenewalSummary = struct {
    /// Contains information about the validation of each domain name in the
    /// certificate, as it
    /// pertains to Lightsail's managed renewal. This is different from the initial
    /// validation that
    /// occurs as a result of the RequestCertificate request.
    domain_validation_options: ?[]const LoadBalancerTlsCertificateDomainValidationOption = null,

    /// The renewal status of the certificate.
    ///
    /// The following renewal status are possible:
    ///
    /// * **
    /// `PendingAutoRenewal`
    /// ** - Lightsail is
    /// attempting to automatically validate the domain names of the certificate. No
    /// further
    /// action is required.
    ///
    /// * **
    /// `PendingValidation`
    /// ** - Lightsail couldn't
    /// automatically validate one or more domain names of the certificate. You must
    /// take action
    /// to validate these domain names or the certificate won't be renewed. Check to
    /// make sure
    /// your certificate's domain validation records exist in your domain's DNS, and
    /// that your
    /// certificate remains in use.
    ///
    /// * **
    /// `Success`
    /// ** - All domain names in the
    /// certificate are validated, and Lightsail renewed the certificate. No further
    /// action is
    /// required.
    ///
    /// * **
    /// `Failed`
    /// ** - One or more domain names were
    /// not validated before the certificate expired, and Lightsail did not renew
    /// the
    /// certificate. You can request a new certificate using the `CreateCertificate`
    /// action.
    renewal_status: ?LoadBalancerTlsCertificateRenewalStatus = null,

    pub const json_field_names = .{
        .domain_validation_options = "domainValidationOptions",
        .renewal_status = "renewalStatus",
    };
};
