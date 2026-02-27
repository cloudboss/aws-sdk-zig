pub const RevocationReason = enum {
    unspecified,
    key_compromise,
    ca_compromise,
    affiliation_changed,
    superceded,
    superseded,
    cessation_of_operation,
    certificate_hold,
    remove_from_crl,
    privilege_withdrawn,
    a_a_compromise,

    pub const json_field_names = .{
        .unspecified = "UNSPECIFIED",
        .key_compromise = "KEY_COMPROMISE",
        .ca_compromise = "CA_COMPROMISE",
        .affiliation_changed = "AFFILIATION_CHANGED",
        .superceded = "SUPERCEDED",
        .superseded = "SUPERSEDED",
        .cessation_of_operation = "CESSATION_OF_OPERATION",
        .certificate_hold = "CERTIFICATE_HOLD",
        .remove_from_crl = "REMOVE_FROM_CRL",
        .privilege_withdrawn = "PRIVILEGE_WITHDRAWN",
        .a_a_compromise = "A_A_COMPROMISE",
    };
};
