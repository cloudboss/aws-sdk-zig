pub const LoadBalancerTlsCertificateRevocationReason = enum {
    unspecified,
    key_compromise,
    ca_compromise,
    affiliation_changed,
    superceded,
    cessation_of_operation,
    certificate_hold,
    remove_from_crl,
    privilege_withdrawn,
    aa_compromise,

    pub const json_field_names = .{
        .unspecified = "Unspecified",
        .key_compromise = "KeyCompromise",
        .ca_compromise = "CaCompromise",
        .affiliation_changed = "AffiliationChanged",
        .superceded = "Superceded",
        .cessation_of_operation = "CessationOfOperation",
        .certificate_hold = "CertificateHold",
        .remove_from_crl = "RemoveFromCrl",
        .privilege_withdrawn = "PrivilegeWithdrawn",
        .aa_compromise = "AACompromise",
    };
};
