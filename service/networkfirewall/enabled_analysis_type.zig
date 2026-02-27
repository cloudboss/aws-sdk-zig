pub const EnabledAnalysisType = enum {
    tls_sni,
    http_host,

    pub const json_field_names = .{
        .tls_sni = "TLS_SNI",
        .http_host = "HTTP_HOST",
    };
};
