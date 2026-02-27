const RevocationCheckAction = @import("revocation_check_action.zig").RevocationCheckAction;

/// Defines the actions to take on the SSL/TLS connection if the certificate
/// presented by the server in the connection has a revoked or unknown status.
pub const CheckCertificateRevocationStatusActions = struct {
    /// Configures how Network Firewall processes traffic when it determines that
    /// the certificate presented by the server in the SSL/TLS connection has a
    /// revoked status.
    ///
    /// * **PASS** - Allow the connection to continue, and pass subsequent packets
    ///   to the stateful engine for inspection.
    ///
    /// * **DROP** - Network Firewall closes the connection and drops subsequent
    ///   packets for that connection.
    ///
    /// * **REJECT** - Network Firewall sends a TCP reject packet back to your
    ///   client. The service closes the connection and drops subsequent packets for
    ///   that connection. `REJECT` is available only for TCP traffic.
    revoked_status_action: ?RevocationCheckAction,

    /// Configures how Network Firewall processes traffic when it determines that
    /// the certificate presented by the server in the SSL/TLS connection has an
    /// unknown status, or a status that cannot be determined for any other reason,
    /// including when the service is unable to connect to the OCSP and CRL
    /// endpoints for the certificate.
    ///
    /// * **PASS** - Allow the connection to continue, and pass subsequent packets
    ///   to the stateful engine for inspection.
    ///
    /// * **DROP** - Network Firewall closes the connection and drops subsequent
    ///   packets for that connection.
    ///
    /// * **REJECT** - Network Firewall sends a TCP reject packet back to your
    ///   client. The service closes the connection and drops subsequent packets for
    ///   that connection. `REJECT` is available only for TCP traffic.
    unknown_status_action: ?RevocationCheckAction,

    pub const json_field_names = .{
        .revoked_status_action = "RevokedStatusAction",
        .unknown_status_action = "UnknownStatusAction",
    };
};
