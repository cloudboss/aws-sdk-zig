const HandshakePartyType = @import("handshake_party_type.zig").HandshakePartyType;

/// Contains details for a participant in a handshake.
pub const HandshakeParty = struct {
    /// ID for the participant: Acccount ID, organization ID, or email address.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for handshake ID string
    /// requires "h-"
    /// followed by from 8 to 32 lowercase letters or digits.
    id: []const u8,

    /// The type of ID for the participant.
    @"type": HandshakePartyType,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
