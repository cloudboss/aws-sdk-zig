pub const CustomDomainAssociationStatus = enum {
    creating,
    create_failed,
    active,
    deleting,
    delete_failed,
    pending_certificate_dns_validation,
    binding_certificate,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .pending_certificate_dns_validation = "PENDING_CERTIFICATE_DNS_VALIDATION",
        .binding_certificate = "BINDING_CERTIFICATE",
    };
};
