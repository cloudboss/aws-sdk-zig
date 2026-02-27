const MediaPipelineTaskStatus = @import("media_pipeline_task_status.zig").MediaPipelineTaskStatus;

/// A representation of an asynchronous request to perform voice tone analysis
/// on a media insights pipeline.
pub const VoiceToneAnalysisTask = struct {
    /// The time at which a voice tone analysis task was created.
    created_timestamp: ?i64,

    /// The time at which a voice tone analysis task was updated.
    updated_timestamp: ?i64,

    /// The ID of the voice tone analysis task.
    voice_tone_analysis_task_id: ?[]const u8,

    /// The status of a voice tone analysis task.
    voice_tone_analysis_task_status: ?MediaPipelineTaskStatus,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_tone_analysis_task_id = "VoiceToneAnalysisTaskId",
        .voice_tone_analysis_task_status = "VoiceToneAnalysisTaskStatus",
    };
};
