const ValidationChallenge = @import("validation_challenge.zig").ValidationChallenge;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;
const DomainStatus = @import("domain_status.zig").DomainStatus;

/// Contains the validation method, validation status, and validation challenge
/// details for a domain. This structure appears in DomainValidationSummary as
/// both the active and requested validation configuration.
pub const ValidationConfiguration = struct {
    /// The validation challenge details for this configuration. The structure
    /// varies by validation method: for DNS validation, contains a
    /// `DnsValidationChallenge` with the CNAME record to add; for email validation,
    /// contains an `EmailValidationChallenge` with the validation email addresses.
    validation_challenge: ?ValidationChallenge = null,

    /// The validation method for this configuration. Valid values:
    ///
    /// * `DNS` – Validation using a CNAME record added to your DNS configuration.
    /// * `EMAIL` – Validation using an approval email sent to domain contacts.
    /// * `HTTP` – Validation using an HTTP resource placed on your web server.
    validation_method: ?ValidationMethod = null,

    /// The validation status for this domain. Valid values:
    ///
    /// * `PENDING_VALIDATION` – The domain is waiting for validation to complete.
    /// * `SUCCESS` – Validation completed successfully.
    /// * `FAILED` – Validation failed.
    validation_status: ?DomainStatus = null,

    pub const json_field_names = .{
        .validation_challenge = "ValidationChallenge",
        .validation_method = "ValidationMethod",
        .validation_status = "ValidationStatus",
    };
};
