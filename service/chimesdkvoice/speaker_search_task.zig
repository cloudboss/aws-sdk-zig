const CallDetails = @import("call_details.zig").CallDetails;
const SpeakerSearchDetails = @import("speaker_search_details.zig").SpeakerSearchDetails;

/// A representation of an asynchronous request to perform speaker search
/// analysis on a
/// Voice Connector call.
pub const SpeakerSearchTask = struct {
    /// The call details of a speaker search task.
    call_details: ?CallDetails = null,

    /// The time at which a speaker search task was created.
    created_timestamp: ?i64 = null,

    /// The details of a speaker search task.
    speaker_search_details: ?SpeakerSearchDetails = null,

    /// The speaker search task ID.
    speaker_search_task_id: ?[]const u8 = null,

    /// The status of the speaker search task, `IN_QUEUE`, `IN_PROGRESS`,
    /// `PARTIAL_SUCCESS`, `SUCCEEDED`,
    /// `FAILED`, or `STOPPED`.
    speaker_search_task_status: ?[]const u8 = null,

    /// The time at which the speaker search task began.
    started_timestamp: ?i64 = null,

    /// A detailed message about the status of a speaker search.
    status_message: ?[]const u8 = null,

    /// The time at which a speaker search task was updated.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .call_details = "CallDetails",
        .created_timestamp = "CreatedTimestamp",
        .speaker_search_details = "SpeakerSearchDetails",
        .speaker_search_task_id = "SpeakerSearchTaskId",
        .speaker_search_task_status = "SpeakerSearchTaskStatus",
        .started_timestamp = "StartedTimestamp",
        .status_message = "StatusMessage",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
