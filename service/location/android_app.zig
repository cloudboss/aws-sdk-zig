/// Unique identifying information for an Android app. Consists of a package
/// name and a 20 byte SHA-1 certificate fingerprint.
pub const AndroidApp = struct {
    /// 20 byte SHA-1 certificate fingerprint associated with the Android app
    /// signing certificate.
    certificate_fingerprint: []const u8,

    /// Unique package name for an Android app.
    package: []const u8,

    pub const json_field_names = .{
        .certificate_fingerprint = "CertificateFingerprint",
        .package = "Package",
    };
};
