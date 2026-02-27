/// Specifies the status and settings of the voice channel for an application.
pub const VoiceChannelRequest = struct {
    /// Specifies whether to enable the voice channel for the application.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
