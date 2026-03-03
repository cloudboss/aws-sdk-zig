const ActionType = @import("action_type.zig").ActionType;

/// Contains the filter used to select the handshakes for an operation.
pub const HandshakeFilter = struct {
    /// The type of handshake.
    ///
    /// If you specify `ActionType`, you cannot also specify
    /// `ParentHandshakeId`.
    action_type: ?ActionType = null,

    /// The parent handshake. Only used for handshake types that are a child of
    /// another
    /// type.
    ///
    /// If you specify `ParentHandshakeId`, you cannot also specify
    /// `ActionType`.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for handshake ID string
    /// requires "h-"
    /// followed by from 8 to 32 lowercase letters or digits.
    parent_handshake_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_type = "ActionType",
        .parent_handshake_id = "ParentHandshakeId",
    };
};
