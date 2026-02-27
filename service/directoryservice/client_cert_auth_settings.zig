/// Contains information about the client certificate authentication settings
/// for the
/// `RegisterCertificate` and `DescribeCertificate` operations.
pub const ClientCertAuthSettings = struct {
    /// Specifies the URL of the default OCSP server used to check for revocation
    /// status. A
    /// secondary value to any OCSP address found in the AIA extension of the user
    /// certificate.
    ocsp_url: ?[]const u8,

    pub const json_field_names = .{
        .ocsp_url = "OCSPUrl",
    };
};
