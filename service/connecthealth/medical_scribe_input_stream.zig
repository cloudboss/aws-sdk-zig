const MedicalScribeAudioEvent = @import("medical_scribe_audio_event.zig").MedicalScribeAudioEvent;
const MedicalScribeBinaryAudioEvent = @import("medical_scribe_binary_audio_event.zig").MedicalScribeBinaryAudioEvent;
const MedicalScribeConfigurationEvent = @import("medical_scribe_configuration_event.zig").MedicalScribeConfigurationEvent;
const MedicalScribeSessionControlEvent = @import("medical_scribe_session_control_event.zig").MedicalScribeSessionControlEvent;

/// Input stream for Medical Scribe containing audio and configuration events
pub const MedicalScribeInputStream = union(enum) {
    audio_event: ?MedicalScribeAudioEvent,
    /// An event containing raw binary audio data for the Medical Scribe stream. The
    /// audio is sent as a raw binary payload rather than as a base64-encoded value.
    binary_audio_event: ?MedicalScribeBinaryAudioEvent,
    configuration_event: ?MedicalScribeConfigurationEvent,
    session_control_event: ?MedicalScribeSessionControlEvent,

    pub const json_field_names = .{
        .audio_event = "audioEvent",
        .binary_audio_event = "binaryAudioEvent",
        .configuration_event = "configurationEvent",
        .session_control_event = "sessionControlEvent",
    };
};
