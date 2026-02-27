const ParticipantCapabilities = @import("participant_capabilities.zig").ParticipantCapabilities;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;

/// The details to add for the participant.
pub const ParticipantDetailsToAdd = struct {
    /// The display name of the participant.
    display_name: ?[]const u8,

    participant_capabilities: ?ParticipantCapabilities,

    /// The role of the participant being added.
    participant_role: ?ParticipantRole,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .participant_capabilities = "ParticipantCapabilities",
        .participant_role = "ParticipantRole",
    };
};
