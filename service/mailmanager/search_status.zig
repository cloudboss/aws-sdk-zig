const SearchState = @import("search_state.zig").SearchState;

/// The current status of an archive search job.
pub const SearchStatus = struct {
    /// The timestamp of when the search completed (if finished).
    completion_timestamp: ?i64 = null,

    /// An error message if the search failed.
    error_message: ?[]const u8 = null,

    /// The current state of the search job.
    state: ?SearchState = null,

    /// The timestamp of when the search was submitted.
    submission_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .completion_timestamp = "CompletionTimestamp",
        .error_message = "ErrorMessage",
        .state = "State",
        .submission_timestamp = "SubmissionTimestamp",
    };
};
