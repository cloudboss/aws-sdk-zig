/// A static structure that contains the configuration data for a
/// `VoiceEnhancementSinkConfiguration` element.
pub const VoiceEnhancementSinkConfiguration = struct {
    /// Disables the `VoiceEnhancementSinkConfiguration` element.
    disabled: bool = false,

    pub const json_field_names = .{
        .disabled = "Disabled",
    };
};
