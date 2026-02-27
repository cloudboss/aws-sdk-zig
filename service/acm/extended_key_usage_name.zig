pub const ExtendedKeyUsageName = enum {
    tls_web_server_authentication,
    tls_web_client_authentication,
    code_signing,
    email_protection,
    time_stamping,
    ocsp_signing,
    ipsec_end_system,
    ipsec_tunnel,
    ipsec_user,
    any,
    none,
    custom,

    pub const json_field_names = .{
        .tls_web_server_authentication = "TLS_WEB_SERVER_AUTHENTICATION",
        .tls_web_client_authentication = "TLS_WEB_CLIENT_AUTHENTICATION",
        .code_signing = "CODE_SIGNING",
        .email_protection = "EMAIL_PROTECTION",
        .time_stamping = "TIME_STAMPING",
        .ocsp_signing = "OCSP_SIGNING",
        .ipsec_end_system = "IPSEC_END_SYSTEM",
        .ipsec_tunnel = "IPSEC_TUNNEL",
        .ipsec_user = "IPSEC_USER",
        .any = "ANY",
        .none = "NONE",
        .custom = "CUSTOM",
    };
};
