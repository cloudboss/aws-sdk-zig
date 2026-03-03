const ModelStatus = @import("model_status.zig").ModelStatus;

/// Provides information for filtering a list of entity recognizers. You can
/// only specify one
/// filtering parameter in a request. For more information, see the
/// `ListEntityRecognizers` operation./>
pub const EntityRecognizerFilter = struct {
    /// The name that you assigned the entity recognizer.
    recognizer_name: ?[]const u8 = null,

    /// The status of an entity recognizer.
    status: ?ModelStatus = null,

    /// Filters the list of entities based on the time that the list was submitted
    /// for processing.
    /// Returns only jobs submitted after the specified time. Jobs are returned in
    /// ascending order,
    /// oldest to newest.
    submit_time_after: ?i64 = null,

    /// Filters the list of entities based on the time that the list was submitted
    /// for processing.
    /// Returns only jobs submitted before the specified time. Jobs are returned in
    /// descending order,
    /// newest to oldest.
    submit_time_before: ?i64 = null,

    pub const json_field_names = .{
        .recognizer_name = "RecognizerName",
        .status = "Status",
        .submit_time_after = "SubmitTimeAfter",
        .submit_time_before = "SubmitTimeBefore",
    };
};
