const MediaPipelineTaskStatus = @import("media_pipeline_task_status.zig").MediaPipelineTaskStatus;

/// A representation of an asynchronous request to perform speaker search
/// analysis on a
/// media insights pipeline.
pub const SpeakerSearchTask = struct {
    /// The time at which a speaker search task was created.
    created_timestamp: ?i64 = null,

    /// The speaker search task ID.
    speaker_search_task_id: ?[]const u8 = null,

    /// The status of the speaker search task.
    speaker_search_task_status: ?MediaPipelineTaskStatus = null,

    /// The time at which a speaker search task was updated.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .speaker_search_task_id = "SpeakerSearchTaskId",
        .speaker_search_task_status = "SpeakerSearchTaskStatus",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
