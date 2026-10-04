const FailureDetails = @import("failure_details.zig").FailureDetails;
const PrevalidationDetails = @import("prevalidation_details.zig").PrevalidationDetails;
const PrevalidationType = @import("prevalidation_type.zig").PrevalidationType;
const AcmeDomainValidationStatus = @import("acme_domain_validation_status.zig").AcmeDomainValidationStatus;

/// Contains detailed information about an ACME domain validation.
pub const AcmeDomainValidation = struct {
    /// The Amazon Resource Name (ARN) of the ACME domain validation.
    acme_domain_validation_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ACME endpoint.
    acme_endpoint_arn: ?[]const u8 = null,

    /// The time at which the domain validation was created.
    created_at: ?i64 = null,

    /// The domain name being validated.
    domain_name: ?[]const u8 = null,

    /// Details about the failure, if the validation failed.
    failure_details: ?FailureDetails = null,

    /// Details about the prevalidation configuration.
    prevalidation_details: ?PrevalidationDetails = null,

    /// The type of prevalidation used.
    prevalidation_type: ?PrevalidationType = null,

    /// The status of the domain validation.
    status: ?AcmeDomainValidationStatus = null,

    /// The time at which the domain validation was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acme_domain_validation_arn = "AcmeDomainValidationArn",
        .acme_endpoint_arn = "AcmeEndpointArn",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .failure_details = "FailureDetails",
        .prevalidation_details = "PrevalidationDetails",
        .prevalidation_type = "PrevalidationType",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
