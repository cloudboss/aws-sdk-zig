const DomainValidationRecord = @import("domain_validation_record.zig").DomainValidationRecord;
const RenewalSummary = @import("renewal_summary.zig").RenewalSummary;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const Tag = @import("tag.zig").Tag;

/// Describes the full details of an Amazon Lightsail SSL/TLS certificate.
///
/// To get a summary of a certificate, use the `GetCertificates` action and omit
/// `includeCertificateDetails` from your request. The response will include
/// only
/// the certificate Amazon Resource Name (ARN), certificate name, domain name,
/// and tags.
pub const Certificate = struct {
    /// The Amazon Resource Name (ARN) of the certificate.
    arn: ?[]const u8,

    /// The timestamp when the certificate was created.
    created_at: ?i64,

    /// The domain name of the certificate.
    domain_name: ?[]const u8,

    /// An array of objects that describe the domain validation records of the
    /// certificate.
    domain_validation_records: ?[]const DomainValidationRecord,

    /// The renewal eligibility of the certificate.
    eligible_to_renew: ?[]const u8,

    /// The number of Lightsail resources that the certificate is attached to.
    in_use_resource_count: i32 = 0,

    /// The timestamp when the certificate was issued.
    issued_at: ?i64,

    /// The certificate authority that issued the certificate.
    issuer_ca: ?[]const u8,

    /// The algorithm used to generate the key pair (the public and private key) of
    /// the
    /// certificate.
    key_algorithm: ?[]const u8,

    /// The name of the certificate (`my-certificate`).
    name: ?[]const u8,

    /// The timestamp when the certificate expires.
    not_after: ?i64,

    /// The timestamp when the certificate is first valid.
    not_before: ?i64,

    /// An object that describes the status of the certificate renewal managed by
    /// Lightsail.
    renewal_summary: ?RenewalSummary,

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
    /// 1000 websites. To provide the required information, use the [Amazon Web
    /// Services Support
    /// Center](https://console.aws.amazon.com/support/home) to contact Amazon Web
    /// Services Support.
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
    /// the [Amazon Web Services Support
    /// Center](https://console.aws.amazon.com/support/home) and create a case.
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
    request_failure_reason: ?[]const u8,

    /// The reason the certificate was revoked. This value is present only when the
    /// certificate
    /// status is `REVOKED`.
    revocation_reason: ?[]const u8,

    /// The timestamp when the certificate was revoked. This value is present only
    /// when the
    /// certificate status is `REVOKED`.
    revoked_at: ?i64,

    /// The serial number of the certificate.
    serial_number: ?[]const u8,

    /// The validation status of the certificate.
    status: ?CertificateStatus,

    /// An array of strings that specify the alternate domains (`example2.com`) and
    /// subdomains (`blog.example.com`) of the certificate.
    subject_alternative_names: ?[]const []const u8,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail certificate. This code enables our support team to look up
    /// your Lightsail
    /// information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_name = "domainName",
        .domain_validation_records = "domainValidationRecords",
        .eligible_to_renew = "eligibleToRenew",
        .in_use_resource_count = "inUseResourceCount",
        .issued_at = "issuedAt",
        .issuer_ca = "issuerCA",
        .key_algorithm = "keyAlgorithm",
        .name = "name",
        .not_after = "notAfter",
        .not_before = "notBefore",
        .renewal_summary = "renewalSummary",
        .request_failure_reason = "requestFailureReason",
        .revocation_reason = "revocationReason",
        .revoked_at = "revokedAt",
        .serial_number = "serialNumber",
        .status = "status",
        .subject_alternative_names = "subjectAlternativeNames",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
