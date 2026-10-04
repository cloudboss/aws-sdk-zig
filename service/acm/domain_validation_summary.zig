const ValidationConfiguration = @import("validation_configuration.zig").ValidationConfiguration;

/// Contains per-domain validation information for a certificate. This structure
/// is returned as a member of the ListCertificateDomainValidations response.
pub const DomainValidationSummary = struct {
    /// The validation configuration currently in effect for this domain. This
    /// reflects the validation method that ACM is currently using to validate
    /// domain ownership (for example, email or DNS).
    active_validation_configuration: ?ValidationConfiguration = null,

    /// The fully qualified domain name (FQDN) in the certificate for which this
    /// validation summary applies.
    domain_name: []const u8,

    /// The validation configuration for a pending validation method migration. This
    /// field is present only when a migration is in progress (for example, from
    /// email to DNS validation). It contains the target validation method, the
    /// current validation status, and the validation challenge details (such as the
    /// CNAME record to add to your DNS configuration).
    requested_validation_configuration: ?ValidationConfiguration = null,

    pub const json_field_names = .{
        .active_validation_configuration = "ActiveValidationConfiguration",
        .domain_name = "DomainName",
        .requested_validation_configuration = "RequestedValidationConfiguration",
    };
};
