const AsnState = @import("asn_state.zig").AsnState;

/// The Autonomous System Number (ASN) and BYOIP CIDR association.
pub const Byoasn = struct {
    /// A public 2-byte or 4-byte ASN.
    asn: ?[]const u8 = null,

    /// An IPAM ID.
    ipam_id: ?[]const u8 = null,

    /// The provisioning state of the BYOASN.
    state: ?AsnState = null,

    /// The status message.
    status_message: ?[]const u8 = null,
};
