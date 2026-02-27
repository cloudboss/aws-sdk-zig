/// Describes the BGP options.
pub const BgpOptions = struct {
    /// The Peer ASN of the BGP.
    peer_asn: ?i64,

    pub const json_field_names = .{
        .peer_asn = "PeerAsn",
    };
};
