/// The customer's details.
pub const ParticipantDetails = struct {
    /// Display name of the participant.
    display_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
    };
};
