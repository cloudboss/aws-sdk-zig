const aws = @import("aws");

const ParticipantTokenCapability = @import("participant_token_capability.zig").ParticipantTokenCapability;

/// Object specifying an exchanged participant token in a stage, created when an
/// original participant token is updated.
///
/// **Important**: Treat tokens as opaque; i.e., do not build
/// functionality based on token contents. The format of tokens could change in
/// the
/// future.
pub const ExchangedParticipantToken = struct {
    /// Application-provided attributes to encode into the token and attach to a
    /// stage. Map keys and values can contain UTF-8 encoded text. The maximum
    /// length of this field
    /// is 1 KB total. *This field is exposed to all stage participants and should
    /// not be
    /// used for personally identifying, confidential, or sensitive
    /// information.*
    attributes: ?[]const aws.map.StringMapEntry,

    /// Set of capabilities that the user is allowed to perform in the stage.
    capabilities: ?[]const ParticipantTokenCapability,

    /// ISO 8601 timestamp (returned as a string) for when this token expires.
    expiration_time: ?i64,

    /// Customer-assigned name to help identify the token; this can be used to link
    /// a
    /// participant to a user in the customer’s own systems. This can be any UTF-8
    /// encoded text.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information.*
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .capabilities = "capabilities",
        .expiration_time = "expirationTime",
        .user_id = "userId",
    };
};
