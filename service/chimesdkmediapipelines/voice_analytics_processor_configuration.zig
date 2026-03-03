const VoiceAnalyticsConfigurationStatus = @import("voice_analytics_configuration_status.zig").VoiceAnalyticsConfigurationStatus;

/// The configuration settings for a voice analytics processor.
pub const VoiceAnalyticsProcessorConfiguration = struct {
    /// The status of the speaker search task.
    speaker_search_status: ?VoiceAnalyticsConfigurationStatus = null,

    /// The status of the voice tone analysis task.
    voice_tone_analysis_status: ?VoiceAnalyticsConfigurationStatus = null,

    pub const json_field_names = .{
        .speaker_search_status = "SpeakerSearchStatus",
        .voice_tone_analysis_status = "VoiceToneAnalysisStatus",
    };
};
