/// Template configurations for v4 template schema.
pub const EnrollmentFlagsV4 = struct {
    /// Allow renewal using the same key.
    enable_key_reuse_on_nt_token_keyset_storage_full: ?bool,

    /// Include symmetric algorithms allowed by the subject.
    include_symmetric_algorithms: ?bool,

    /// This flag instructs the CA to not include the security extension
    /// szOID_NTDS_CA_SECURITY_EXT (OID:1.3.6.1.4.1.311.25.2), as specified in
    /// [MS-WCCE] sections
    /// 2.2.2.7.7.4 and 3.2.2.6.2.1.4.5.9, in the issued certificate. This addresses
    /// a Windows
    /// Kerberos elevation-of-privilege vulnerability.
    no_security_extension: ?bool,

    /// Delete expired or revoked certificates instead of archiving them.
    remove_invalid_certificate_from_personal_store: ?bool,

    /// Require user interaction when the subject is enrolled and the private key
    /// associated
    /// with the certificate is used.
    user_interaction_required: ?bool,

    pub const json_field_names = .{
        .enable_key_reuse_on_nt_token_keyset_storage_full = "EnableKeyReuseOnNtTokenKeysetStorageFull",
        .include_symmetric_algorithms = "IncludeSymmetricAlgorithms",
        .no_security_extension = "NoSecurityExtension",
        .remove_invalid_certificate_from_personal_store = "RemoveInvalidCertificateFromPersonalStore",
        .user_interaction_required = "UserInteractionRequired",
    };
};
