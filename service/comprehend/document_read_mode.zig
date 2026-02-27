pub const DocumentReadMode = enum {
    service_default,
    force_document_read_action,

    pub const json_field_names = .{
        .service_default = "SERVICE_DEFAULT",
        .force_document_read_action = "FORCE_DOCUMENT_READ_ACTION",
    };
};
