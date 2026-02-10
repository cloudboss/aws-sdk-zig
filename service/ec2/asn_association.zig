const AsnAssociationState = @import("asn_association_state.zig").AsnAssociationState;

/// An Autonomous System Number (ASN) and BYOIP CIDR association.
pub const AsnAssociation = struct {
    /// The association's ASN.
    asn: ?[]const u8,

    /// The association's CIDR.
    cidr: ?[]const u8,

    /// The association's state.
    state: ?AsnAssociationState,

    /// The association's status message.
    status_message: ?[]const u8,
};
