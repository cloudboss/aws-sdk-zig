pub const LoadBalancerTlsCertificateFailureReason = enum {
    no_available_contacts,
    additional_verification_required,
    domain_not_allowed,
    invalid_public_domain,
    other,

    pub const json_field_names = .{
        .no_available_contacts = "NoAvailableContacts",
        .additional_verification_required = "AdditionalVerificationRequired",
        .domain_not_allowed = "DomainNotAllowed",
        .invalid_public_domain = "InvalidPublicDomain",
        .other = "Other",
    };
};
