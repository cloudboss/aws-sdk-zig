const ResponseMode = @import("response_mode.zig").ResponseMode;

/// The configuration of the participant.
pub const ParticipantConfiguration = struct {
    /// The mode in which responses should be sent to the participant.
    response_mode: ?ResponseMode,

    pub const json_field_names = .{
        .response_mode = "ResponseMode",
    };
};
