const ParticipantRole = @import("participant_role.zig").ParticipantRole;

/// The contact configuration for push notification registration.
pub const ContactConfiguration = struct {
    /// The identifier of the contact within the Amazon Connect instance.
    contact_id: []const u8,

    /// Whether to include raw connect message in the push notification payload.
    /// Default is `False`.
    include_raw_message: bool = false,

    /// The role of the participant in the chat conversation.
    ///
    /// Only `CUSTOMER` is currently supported. Any other values other than
    /// `CUSTOMER` will
    /// result in an exception (4xx error).
    participant_role: ?ParticipantRole = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .include_raw_message = "IncludeRawMessage",
        .participant_role = "ParticipantRole",
    };
};
