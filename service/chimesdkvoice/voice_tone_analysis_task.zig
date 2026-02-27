const CallDetails = @import("call_details.zig").CallDetails;

/// A representation of an asynchronous request to perform voice tone analysis
/// on a Voice Connector call.
pub const VoiceToneAnalysisTask = struct {
    /// The call details of a voice tone analysis task.
    call_details: ?CallDetails,

    /// The time at which a voice tone analysis task was created.
    created_timestamp: ?i64,

    /// The time at which a voice tone analysis task started.
    started_timestamp: ?i64,

    /// The status of a voice tone analysis task.
    status_message: ?[]const u8,

    /// The time at which a voice tone analysis task was updated.
    updated_timestamp: ?i64,

    /// The ID of the voice tone analysis task.
    voice_tone_analysis_task_id: ?[]const u8,

    /// The status of a voice tone analysis task, `IN_QUEUE`, `IN_PROGRESS`,
    /// `PARTIAL_SUCCESS`, `SUCCEEDED`,
    /// `FAILED`, or `STOPPED`.
    voice_tone_analysis_task_status: ?[]const u8,

    pub const json_field_names = .{
        .call_details = "CallDetails",
        .created_timestamp = "CreatedTimestamp",
        .started_timestamp = "StartedTimestamp",
        .status_message = "StatusMessage",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_tone_analysis_task_id = "VoiceToneAnalysisTaskId",
        .voice_tone_analysis_task_status = "VoiceToneAnalysisTaskStatus",
    };
};
