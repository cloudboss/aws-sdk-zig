/// Provides statistics for the specified `ImportID`. CloudTrail does not
/// update import statistics in real-time. Returned values for parameters such
/// as
/// `EventsCompleted` may be lower than the actual value, because CloudTrail
/// updates statistics incrementally over the course of the import.
pub const ImportStatistics = struct {
    /// The number of trail events imported into the event data store.
    events_completed: ?i64 = null,

    /// The number of failed entries.
    failed_entries: ?i64 = null,

    /// The number of log files that completed import.
    files_completed: ?i64 = null,

    /// The number of S3 prefixes that completed import.
    prefixes_completed: ?i64 = null,

    /// The number of S3 prefixes found for the import.
    prefixes_found: ?i64 = null,

    pub const json_field_names = .{
        .events_completed = "EventsCompleted",
        .failed_entries = "FailedEntries",
        .files_completed = "FilesCompleted",
        .prefixes_completed = "PrefixesCompleted",
        .prefixes_found = "PrefixesFound",
    };
};
