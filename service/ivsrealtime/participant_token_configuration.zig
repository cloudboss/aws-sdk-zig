const aws = @import("aws");

const ParticipantTokenCapability = @import("participant_token_capability.zig").ParticipantTokenCapability;

/// Object specifying a participant token configuration in a stage.
pub const ParticipantTokenConfiguration = struct {
    /// Application-provided attributes to encode into the corresponding participant
    /// token and
    /// attach to a stage. Map keys and values can contain UTF-8 encoded text. The
    /// maximum length
    /// of this field is 1 KB total. *This field is exposed to all stage
    /// participants and
    /// should not be used for personally identifying, confidential, or sensitive
    /// information.*
    attributes: ?[]const aws.map.StringMapEntry,

    /// Set of capabilities that the user is allowed to perform in the stage.
    capabilities: ?[]const ParticipantTokenCapability,

    /// Duration (in minutes), after which the corresponding participant token
    /// expires. Default:
    /// 720 (12 hours).
    duration: ?i32,

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
        .duration = "duration",
        .user_id = "userId",
    };
};
