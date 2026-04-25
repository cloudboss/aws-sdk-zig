const TrustStore = @import("trust_store.zig").TrustStore;

/// The mutual TLS authentication configuration for an ingress endpoint.
pub const TlsAuthConfiguration = struct {
    /// The trust store configuration for mutual TLS authentication.
    trust_store: ?TrustStore = null,

    pub const json_field_names = .{
        .trust_store = "TrustStore",
    };
};
