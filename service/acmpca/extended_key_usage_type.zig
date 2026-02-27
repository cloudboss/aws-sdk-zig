pub const ExtendedKeyUsageType = enum {
    server_auth,
    client_auth,
    code_signing,
    email_protection,
    time_stamping,
    ocsp_signing,
    smart_card_login,
    document_signing,
    certificate_transparency,

    pub const json_field_names = .{
        .server_auth = "SERVER_AUTH",
        .client_auth = "CLIENT_AUTH",
        .code_signing = "CODE_SIGNING",
        .email_protection = "EMAIL_PROTECTION",
        .time_stamping = "TIME_STAMPING",
        .ocsp_signing = "OCSP_SIGNING",
        .smart_card_login = "SMART_CARD_LOGIN",
        .document_signing = "DOCUMENT_SIGNING",
        .certificate_transparency = "CERTIFICATE_TRANSPARENCY",
    };
};
