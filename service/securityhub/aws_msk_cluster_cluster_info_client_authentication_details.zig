const AwsMskClusterClusterInfoClientAuthenticationSaslDetails = @import("aws_msk_cluster_cluster_info_client_authentication_sasl_details.zig").AwsMskClusterClusterInfoClientAuthenticationSaslDetails;
const AwsMskClusterClusterInfoClientAuthenticationTlsDetails = @import("aws_msk_cluster_cluster_info_client_authentication_tls_details.zig").AwsMskClusterClusterInfoClientAuthenticationTlsDetails;
const AwsMskClusterClusterInfoClientAuthenticationUnauthenticatedDetails = @import("aws_msk_cluster_cluster_info_client_authentication_unauthenticated_details.zig").AwsMskClusterClusterInfoClientAuthenticationUnauthenticatedDetails;

/// Provides details about different modes of client authentication.
pub const AwsMskClusterClusterInfoClientAuthenticationDetails = struct {
    /// Provides details for client authentication using SASL.
    sasl: ?AwsMskClusterClusterInfoClientAuthenticationSaslDetails = null,

    /// Provides details for client authentication using TLS.
    tls: ?AwsMskClusterClusterInfoClientAuthenticationTlsDetails = null,

    /// Provides details for allowing no client authentication.
    unauthenticated: ?AwsMskClusterClusterInfoClientAuthenticationUnauthenticatedDetails = null,

    pub const json_field_names = .{
        .sasl = "Sasl",
        .tls = "Tls",
        .unauthenticated = "Unauthenticated",
    };
};
