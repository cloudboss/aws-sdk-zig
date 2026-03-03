const LoadBalancerTlsCertificateDomainValidationRecord = @import("load_balancer_tls_certificate_domain_validation_record.zig").LoadBalancerTlsCertificateDomainValidationRecord;
const LoadBalancerTlsCertificateFailureReason = @import("load_balancer_tls_certificate_failure_reason.zig").LoadBalancerTlsCertificateFailureReason;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const LoadBalancerTlsCertificateRenewalSummary = @import("load_balancer_tls_certificate_renewal_summary.zig").LoadBalancerTlsCertificateRenewalSummary;
const ResourceType = @import("resource_type.zig").ResourceType;
const LoadBalancerTlsCertificateRevocationReason = @import("load_balancer_tls_certificate_revocation_reason.zig").LoadBalancerTlsCertificateRevocationReason;
const LoadBalancerTlsCertificateStatus = @import("load_balancer_tls_certificate_status.zig").LoadBalancerTlsCertificateStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a load balancer SSL/TLS certificate.
///
/// TLS is just an updated, more secure version of Secure Socket Layer (SSL).
pub const LoadBalancerTlsCertificate = struct {
    /// The Amazon Resource Name (ARN) of the SSL/TLS certificate.
    arn: ?[]const u8 = null,

    /// The time when you created your SSL/TLS certificate.
    created_at: ?i64 = null,

    /// The domain name for your SSL/TLS certificate.
    domain_name: ?[]const u8 = null,

    /// An array of LoadBalancerTlsCertificateDomainValidationRecord objects
    /// describing the
    /// records.
    domain_validation_records: ?[]const LoadBalancerTlsCertificateDomainValidationRecord = null,

    /// The validation failure reason, if any, of the certificate.
    ///
    /// The following failure reasons are possible:
    ///
    /// * **
    /// `NO_AVAILABLE_CONTACTS`
    /// ** - This failure
    /// applies to email validation, which is not available for Lightsail
    /// certificates.
    ///
    /// * **
    /// `ADDITIONAL_VERIFICATION_REQUIRED`
    /// ** -
    /// Lightsail requires additional information to process this certificate
    /// request. This can
    /// happen as a fraud-protection measure, such as when the domain ranks within
    /// the Alexa top
    /// 1000 websites. To provide the required information, use the [AWS Support
    /// Center](https://console.aws.amazon.com/support/home) to contact
    /// AWS Support.
    ///
    /// You cannot request a certificate for Amazon-owned domain names such as those
    /// ending
    /// in amazonaws.com, cloudfront.net, or elasticbeanstalk.com.
    ///
    /// * **
    /// `DOMAIN_NOT_ALLOWED`
    /// ** - One or more of the
    /// domain names in the certificate request was reported as an unsafe domain by
    /// [VirusTotal](https://www.virustotal.com/gui/home/url). To correct the
    /// problem, search for your domain name on the
    /// [VirusTotal](https://www.virustotal.com/gui/home/url) website. If your
    /// domain
    /// is reported as suspicious, see [Google Help for
    /// Hacked
    /// Websites](https://developers.google.com/web/fundamentals/security/hacked) to
    /// learn what you can do.
    ///
    /// If you believe that the result is a false positive, notify the organization
    /// that is
    /// reporting the domain. VirusTotal is an aggregate of several antivirus and
    /// URL scanners and
    /// cannot remove your domain from a block list itself. After you correct the
    /// problem and the
    /// VirusTotal registry has been updated, request a new certificate.
    ///
    /// If you see this error and your domain is not included in the VirusTotal
    /// list, visit
    /// the [AWS Support Center](https://console.aws.amazon.com/support/home)
    /// and create a case.
    ///
    /// * **
    /// `INVALID_PUBLIC_DOMAIN`
    /// ** - One or more of
    /// the domain names in the certificate request is not valid. Typically, this is
    /// because a
    /// domain name in the request is not a valid top-level domain. Try to request a
    /// certificate
    /// again, correcting any spelling errors or typos that were in the failed
    /// request, and ensure
    /// that all domain names in the request are for valid top-level domains. For
    /// example, you
    /// cannot request a certificate for `example.invalidpublicdomain` because
    /// `invalidpublicdomain` is not a valid top-level domain.
    ///
    /// * **
    /// `OTHER`
    /// ** - Typically, this failure occurs
    /// when there is a typographical error in one or more of the domain names in
    /// the certificate
    /// request. Try to request a certificate again, correcting any spelling errors
    /// or typos that
    /// were in the failed request.
    failure_reason: ?LoadBalancerTlsCertificateFailureReason = null,

    /// When `true`, the SSL/TLS certificate is attached to the Lightsail load
    /// balancer.
    is_attached: ?bool = null,

    /// The time when the SSL/TLS certificate was issued.
    issued_at: ?i64 = null,

    /// The issuer of the certificate.
    issuer: ?[]const u8 = null,

    /// The algorithm used to generate the key pair (the public and private key).
    key_algorithm: ?[]const u8 = null,

    /// The load balancer name where your SSL/TLS certificate is attached.
    load_balancer_name: ?[]const u8 = null,

    /// The Amazon Web Services Region and Availability Zone where you created your
    /// certificate.
    location: ?ResourceLocation = null,

    /// The name of the SSL/TLS certificate (`my-certificate`).
    name: ?[]const u8 = null,

    /// The timestamp when the SSL/TLS certificate expires.
    not_after: ?i64 = null,

    /// The timestamp when the SSL/TLS certificate is first valid.
    not_before: ?i64 = null,

    /// An object that describes the status of the certificate renewal managed by
    /// Lightsail.
    renewal_summary: ?LoadBalancerTlsCertificateRenewalSummary = null,

    /// The resource type (`LoadBalancerTlsCertificate`).
    ///
    /// * **
    /// `Instance`
    /// ** - A Lightsail instance (a
    /// virtual private server)
    ///
    /// * **
    /// `StaticIp`
    /// ** - A static IP address
    ///
    /// * **
    /// `KeyPair`
    /// ** - The key pair used to connect
    /// to a Lightsail instance
    ///
    /// * **
    /// `InstanceSnapshot`
    /// ** - A Lightsail
    /// instance snapshot
    ///
    /// * **
    /// `Domain`
    /// ** - A DNS zone
    ///
    /// * **
    /// `PeeredVpc`
    /// ** - A peered VPC
    ///
    /// * **
    /// `LoadBalancer`
    /// ** - A Lightsail load
    /// balancer
    ///
    /// * **
    /// `LoadBalancerTlsCertificate`
    /// ** - An SSL/TLS
    /// certificate associated with a Lightsail load balancer
    ///
    /// * **
    /// `Disk`
    /// ** - A Lightsail block storage
    /// disk
    ///
    /// * **
    /// `DiskSnapshot`
    /// ** - A block storage disk
    /// snapshot
    resource_type: ?ResourceType = null,

    /// The reason the certificate was revoked. This value is present only when the
    /// certificate
    /// status is `REVOKED`.
    revocation_reason: ?LoadBalancerTlsCertificateRevocationReason = null,

    /// The timestamp when the certificate was revoked. This value is present only
    /// when the
    /// certificate status is `REVOKED`.
    revoked_at: ?i64 = null,

    /// The serial number of the certificate.
    serial: ?[]const u8 = null,

    /// The algorithm that was used to sign the certificate.
    signature_algorithm: ?[]const u8 = null,

    /// The validation status of the SSL/TLS certificate. Valid values are below.
    status: ?LoadBalancerTlsCertificateStatus = null,

    /// The name of the entity that is associated with the public key contained in
    /// the
    /// certificate.
    subject: ?[]const u8 = null,

    /// An array of strings that specify the alternate domains (`example2.com`) and
    /// subdomains (`blog.example.com`) for the certificate.
    subject_alternative_names: ?[]const []const u8 = null,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail load balancer or SSL/TLS certificate. This code enables our
    /// support team to
    /// look up your Lightsail information more easily.
    support_code: ?[]const u8 = null,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_name = "domainName",
        .domain_validation_records = "domainValidationRecords",
        .failure_reason = "failureReason",
        .is_attached = "isAttached",
        .issued_at = "issuedAt",
        .issuer = "issuer",
        .key_algorithm = "keyAlgorithm",
        .load_balancer_name = "loadBalancerName",
        .location = "location",
        .name = "name",
        .not_after = "notAfter",
        .not_before = "notBefore",
        .renewal_summary = "renewalSummary",
        .resource_type = "resourceType",
        .revocation_reason = "revocationReason",
        .revoked_at = "revokedAt",
        .serial = "serial",
        .signature_algorithm = "signatureAlgorithm",
        .status = "status",
        .subject = "subject",
        .subject_alternative_names = "subjectAlternativeNames",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
