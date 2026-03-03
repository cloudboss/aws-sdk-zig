const RouteServerPeerLivenessMode = @import("route_server_peer_liveness_mode.zig").RouteServerPeerLivenessMode;

/// The BGP configuration options requested for a route server peer.
pub const RouteServerBgpOptionsRequest = struct {
    /// The Border Gateway Protocol (BGP) Autonomous System Number (ASN) for the
    /// appliance. Valid values are from 1 to 4294967295. We recommend using a
    /// private ASN in the 64512–65534 (16-bit ASN) or 4200000000–4294967294 (32-bit
    /// ASN) range.
    peer_asn: i64,

    /// The requested liveness detection protocol for the BGP peer.
    ///
    /// * `bgp-keepalive`: The standard BGP keep alive mechanism
    ///   ([RFC4271](https://www.rfc-editor.org/rfc/rfc4271#page-21)) that is stable
    ///   but may take longer to fail-over in cases of network impact or router
    ///   failure.
    ///
    /// * `bfd`: An additional Bidirectional Forwarding Detection (BFD) protocol
    ///   ([RFC5880](https://www.rfc-editor.org/rfc/rfc5880)) that enables fast
    ///   failover by using more sensitive liveness detection.
    ///
    /// Defaults to `bgp-keepalive`.
    peer_liveness_detection: ?RouteServerPeerLivenessMode = null,
};
