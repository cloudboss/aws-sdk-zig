/// Unique identifying information for an Android app. Consists of a package
/// name and a 20 byte SHA-1 certificate fingerprint.
pub const AndroidApp = struct {
    /// 20 byte SHA-1 certificate fingerprint associated with the Android app
    /// signing certificate.
    ///
    /// Example: `BB:0D:AC:74:D3:21:E1:43:67:71:9B:62:91:AF:A1:66:6E:44:5D:75`
    certificate_fingerprint: []const u8,

    /// Unique package name identifier for an Android app.
    ///
    /// Example: `com.mydomain.appname`
    package: []const u8,

    pub const json_field_names = .{
        .certificate_fingerprint = "CertificateFingerprint",
        .package = "Package",
    };
};
