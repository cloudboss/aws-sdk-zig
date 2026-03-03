const ContactParticipantRole = @import("contact_participant_role.zig").ContactParticipantRole;

/// Information about a contact participant in the evaluation.
pub const EvaluationContactParticipant = struct {
    /// The identifier for the contact participant.
    contact_participant_id: ?[]const u8 = null,

    /// The role of the contact participant.
    contact_participant_role: ?ContactParticipantRole = null,

    pub const json_field_names = .{
        .contact_participant_id = "ContactParticipantId",
        .contact_participant_role = "ContactParticipantRole",
    };
};
