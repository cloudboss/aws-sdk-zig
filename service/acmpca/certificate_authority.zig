const CertificateAuthorityConfiguration = @import("certificate_authority_configuration.zig").CertificateAuthorityConfiguration;
const FailureReason = @import("failure_reason.zig").FailureReason;
const KeyStorageSecurityStandard = @import("key_storage_security_standard.zig").KeyStorageSecurityStandard;
const RevocationConfiguration = @import("revocation_configuration.zig").RevocationConfiguration;
const CertificateAuthorityStatus = @import("certificate_authority_status.zig").CertificateAuthorityStatus;
const CertificateAuthorityType = @import("certificate_authority_type.zig").CertificateAuthorityType;
const CertificateAuthorityUsageMode = @import("certificate_authority_usage_mode.zig").CertificateAuthorityUsageMode;

/// Contains information about your private certificate authority (CA). Your
/// private CA can issue and revoke X.509 digital certificates. Digital
/// certificates verify that the entity named in the certificate **Subject**
/// field owns or controls the public key contained in the **Subject Public Key
/// Info** field. Call the
/// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action to create your private CA. You must then call the [GetCertificateAuthorityCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetCertificateAuthorityCertificate.html) action to retrieve a private CA certificate signing request (CSR). Sign the CSR with your Amazon Web Services Private CA-hosted or on-premises root or subordinate CA certificate. Call the [ImportCertificateAuthorityCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ImportCertificateAuthorityCertificate.html) action to import the signed certificate into Certificate Manager (ACM).
pub const CertificateAuthority = struct {
    /// Amazon Resource Name (ARN) for your private certificate authority (CA). The
    /// format is ` *12345678-1234-1234-1234-123456789012* `.
    arn: ?[]const u8,

    /// Your private CA configuration.
    certificate_authority_configuration: ?CertificateAuthorityConfiguration,

    /// Date and time at which your private CA was created.
    created_at: ?i64,

    /// Reason the request to create your private CA failed.
    failure_reason: ?FailureReason,

    /// Defines a cryptographic key management compliance standard for handling and
    /// protecting CA keys.
    ///
    /// Default: FIPS_140_2_LEVEL_3_OR_HIGHER
    ///
    /// Starting January 26, 2023, Amazon Web Services Private CA protects all CA
    /// private keys in non-China regions using hardware security modules (HSMs)
    /// that comply with FIPS PUB 140-2 Level 3.
    ///
    /// For information about security standard support in different Amazon Web
    /// Services Regions, see [Storage and security compliance of Amazon Web
    /// Services Private CA private
    /// keys](https://docs.aws.amazon.com/privateca/latest/userguide/data-protection.html#private-keys).
    key_storage_security_standard: ?KeyStorageSecurityStandard,

    /// Date and time at which your private CA was last updated.
    last_state_change_at: ?i64,

    /// Date and time after which your private CA certificate is not valid.
    not_after: ?i64,

    /// Date and time before which your private CA certificate is not valid.
    not_before: ?i64,

    /// The Amazon Web Services account ID that owns the certificate authority.
    owner_account: ?[]const u8,

    /// The period during which a deleted CA can be restored. For more information,
    /// see the `PermanentDeletionTimeInDays` parameter of the
    /// [DeleteCertificateAuthorityRequest](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeleteCertificateAuthorityRequest.html) action.
    restorable_until: ?i64,

    /// Information about the Online Certificate Status Protocol (OCSP)
    /// configuration or certificate revocation list (CRL) created and maintained by
    /// your private CA.
    revocation_configuration: ?RevocationConfiguration,

    /// Serial number of your private CA.
    serial: ?[]const u8,

    /// Status of your private CA.
    status: ?CertificateAuthorityStatus,

    /// Type of your private CA.
    type: ?CertificateAuthorityType,

    /// Specifies whether the CA issues general-purpose certificates that typically
    /// require a revocation mechanism, or short-lived certificates that may
    /// optionally omit revocation because they expire quickly. Short-lived
    /// certificate validity is limited to seven days.
    ///
    /// The default value is GENERAL_PURPOSE.
    usage_mode: ?CertificateAuthorityUsageMode,

    pub const json_field_names = .{
        .arn = "Arn",
        .certificate_authority_configuration = "CertificateAuthorityConfiguration",
        .created_at = "CreatedAt",
        .failure_reason = "FailureReason",
        .key_storage_security_standard = "KeyStorageSecurityStandard",
        .last_state_change_at = "LastStateChangeAt",
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .owner_account = "OwnerAccount",
        .restorable_until = "RestorableUntil",
        .revocation_configuration = "RevocationConfiguration",
        .serial = "Serial",
        .status = "Status",
        .type = "Type",
        .usage_mode = "UsageMode",
    };
};
