pub const AuthenticationMethod = enum {
    x509_client_certificate,
    signature_version_4,

    pub const json_field_names = .{
        .x509_client_certificate = "X509ClientCertificate",
        .signature_version_4 = "SignatureVersion4",
    };
};
