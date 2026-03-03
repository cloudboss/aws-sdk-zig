/// A trust store configuration.
pub const TrustStoreConfig = struct {
    /// The configuration to use to advertise trust store CA names.
    advertise_trust_store_ca_names: ?bool = null,

    /// The configuration to use to ignore certificate expiration.
    ignore_certificate_expiry: ?bool = null,

    /// The trust store ID.
    trust_store_id: []const u8,
};
