const CertificateKeyPairOrigin = @import("certificate_key_pair_origin.zig").CertificateKeyPairOrigin;
const CertificateExport = @import("certificate_export.zig").CertificateExport;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;
const RenewalStatus = @import("renewal_status.zig").RenewalStatus;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const CertificateType = @import("certificate_type.zig").CertificateType;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;

/// Filters certificates by ACM metadata.
pub const AcmCertificateMetadataFilter = union(enum) {
    /// Filter by ACME account identifier.
    acme_account_id: ?[]const u8,
    /// Filter by ACME endpoint ARN.
    acme_endpoint_arn: ?[]const u8,
    /// Filter by certificate key pair origin.
    certificate_key_pair_origin: ?CertificateKeyPairOrigin,
    /// Filter by whether the certificate has been exported.
    exported: ?bool,
    /// Filter by certificate export option.
    export_option: ?CertificateExport,
    /// Filter by whether the certificate is in use.
    in_use: ?bool,
    /// Filter by the entity that manages the certificate.
    managed_by: ?CertificateManagedBy,
    /// Filter by certificate renewal status.
    renewal_status: ?RenewalStatus,
    /// Filter by certificate status.
    status: ?CertificateStatus,
    /// Filter by certificate type.
    type: ?CertificateType,
    /// Filter by validation method.
    validation_method: ?ValidationMethod,

    pub const json_field_names = .{
        .acme_account_id = "AcmeAccountId",
        .acme_endpoint_arn = "AcmeEndpointArn",
        .certificate_key_pair_origin = "CertificateKeyPairOrigin",
        .exported = "Exported",
        .export_option = "ExportOption",
        .in_use = "InUse",
        .managed_by = "ManagedBy",
        .renewal_status = "RenewalStatus",
        .status = "Status",
        .type = "Type",
        .validation_method = "ValidationMethod",
    };
};
