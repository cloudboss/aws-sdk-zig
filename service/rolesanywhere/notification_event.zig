pub const NotificationEvent = enum {
    ca_certificate_expiry,
    end_entity_certificate_expiry,

    pub const json_field_names = .{
        .ca_certificate_expiry = "CA_CERTIFICATE_EXPIRY",
        .end_entity_certificate_expiry = "END_ENTITY_CERTIFICATE_EXPIRY",
    };
};
