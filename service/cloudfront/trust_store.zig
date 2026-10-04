const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;

/// A trust store.
pub const TrustStore = struct {
    /// The trust store's Amazon Resource Name (ARN).
    arn: ?[]const u8 = null,

    /// The trust store's ID.
    id: ?[]const u8 = null,

    /// The trust store's last modified time.
    last_modified_time: ?i64 = null,

    /// The trust store's name.
    name: ?[]const u8 = null,

    /// The trust store's number of CA certificates.
    number_of_ca_certificates: ?i32 = null,

    /// The trust store's reason.
    reason: ?[]const u8 = null,

    /// The trust store's status.
    status: ?TrustStoreStatus = null,

    /// A Boolean that determines whether the trust store uses the CA certificate's
    /// OCSP endpoint to check certificate revocation status.
    use_client_certificate_ocsp_endpoint: ?bool = null,
};
