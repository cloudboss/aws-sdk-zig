const ExtendedKeyUsageName = @import("extended_key_usage_name.zig").ExtendedKeyUsageName;

/// The Extended Key Usage X.509 v3 extension defines one or more purposes for
/// which the public key can be used. This is in addition to or in place of the
/// basic purposes specified by the Key Usage extension.
pub const ExtendedKeyUsage = struct {
    /// The name of an Extended Key Usage value.
    name: ?ExtendedKeyUsageName = null,

    /// An object identifier (OID) for the extension value. OIDs are strings of
    /// numbers separated by periods. The following OIDs are defined in RFC 3280 and
    /// RFC 5280.
    ///
    /// * `1.3.6.1.5.5.7.3.1 (TLS_WEB_SERVER_AUTHENTICATION)`
    /// * `1.3.6.1.5.5.7.3.2 (TLS_WEB_CLIENT_AUTHENTICATION)`
    /// * `1.3.6.1.5.5.7.3.3 (CODE_SIGNING)`
    /// * `1.3.6.1.5.5.7.3.4 (EMAIL_PROTECTION)`
    /// * `1.3.6.1.5.5.7.3.8 (TIME_STAMPING)`
    /// * `1.3.6.1.5.5.7.3.9 (OCSP_SIGNING)`
    /// * `1.3.6.1.5.5.7.3.5 (IPSEC_END_SYSTEM)`
    /// * `1.3.6.1.5.5.7.3.6 (IPSEC_TUNNEL)`
    /// * `1.3.6.1.5.5.7.3.7 (IPSEC_USER)`
    oid: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .oid = "OID",
    };
};
