const ViewerMtlsMode = @import("viewer_mtls_mode.zig").ViewerMtlsMode;
const TrustStoreConfig = @import("trust_store_config.zig").TrustStoreConfig;

/// A viewer mTLS configuration.
pub const ViewerMtlsConfig = struct {
    /// The viewer mTLS mode.
    mode: ViewerMtlsMode = "required",

    /// The trust store configuration associated with the viewer mTLS configuration.
    trust_store_config: ?TrustStoreConfig,
};
