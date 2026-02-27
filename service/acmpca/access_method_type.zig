pub const AccessMethodType = enum {
    ca_repository,
    resource_pki_manifest,
    resource_pki_notify,

    pub const json_field_names = .{
        .ca_repository = "CA_REPOSITORY",
        .resource_pki_manifest = "RESOURCE_PKI_MANIFEST",
        .resource_pki_notify = "RESOURCE_PKI_NOTIFY",
    };
};
