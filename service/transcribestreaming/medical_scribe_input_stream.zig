const MedicalScribeAudioEvent = @import("medical_scribe_audio_event.zig").MedicalScribeAudioEvent;
const MedicalScribeConfigurationEvent = @import("medical_scribe_configuration_event.zig").MedicalScribeConfigurationEvent;
const MedicalScribeSessionControlEvent = @import("medical_scribe_session_control_event.zig").MedicalScribeSessionControlEvent;

/// An encoded stream of events. The stream is encoded as HTTP/2 data frames.
///
/// An input stream consists of the following types of events. The first element
/// of the input stream must be the `MedicalScribeConfigurationEvent` event
/// type.
///
/// * `MedicalScribeConfigurationEvent`
///
/// * `MedicalScribeAudioEvent`
///
/// * `MedicalScribeSessionControlEvent`
pub const MedicalScribeInputStream = union(enum) {
    audio_event: ?MedicalScribeAudioEvent,
    /// Specify additional streaming session configurations beyond those provided in
    /// your initial start request headers. For example, specify
    /// channel definitions, encryption settings, and post-stream analytics
    /// settings.
    ///
    /// Whether you are starting a new session or resuming an existing session,
    /// your first event must be a `MedicalScribeConfigurationEvent`.
    configuration_event: ?MedicalScribeConfigurationEvent,
    /// Specify the lifecycle of your streaming session, such as ending the session.
    session_control_event: ?MedicalScribeSessionControlEvent,

    pub const json_field_names = .{
        .audio_event = "AudioEvent",
        .configuration_event = "ConfigurationEvent",
        .session_control_event = "SessionControlEvent",
    };
};
