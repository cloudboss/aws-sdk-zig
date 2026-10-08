const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const EncounterContext = @import("encounter_context.zig").EncounterContext;
const MedicalScribePostStreamActionSettings = @import("medical_scribe_post_stream_action_settings.zig").MedicalScribePostStreamActionSettings;

/// An event containing configuration for the Medical Scribe session
pub const MedicalScribeConfigurationEvent = struct {
    /// Channel definitions for the audio stream
    channel_definitions: ?[]const MedicalScribeChannelDefinition = null,

    /// Context information about the clinical encounter
    encounter_context: ?EncounterContext = null,

    /// Settings for actions to perform after the stream ends
    post_stream_action_settings: MedicalScribePostStreamActionSettings,

    pub const json_field_names = .{
        .channel_definitions = "channelDefinitions",
        .encounter_context = "encounterContext",
        .post_stream_action_settings = "postStreamActionSettings",
    };
};
