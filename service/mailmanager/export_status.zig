const ExportState = @import("export_state.zig").ExportState;

/// The current status of an archive export job.
pub const ExportStatus = struct {
    /// The timestamp of when the export job completed (if finished).
    completion_timestamp: ?i64 = null,

    /// An error message if the export job failed.
    error_message: ?[]const u8 = null,

    /// The current state of the export job.
    state: ?ExportState = null,

    /// The timestamp of when the export job was submitted.
    submission_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .completion_timestamp = "CompletionTimestamp",
        .error_message = "ErrorMessage",
        .state = "State",
        .submission_timestamp = "SubmissionTimestamp",
    };
};
