const ContinuationEvent = @import("continuation_event.zig").ContinuationEvent;
const EndEvent = @import("end_event.zig").EndEvent;
const ProgressEvent = @import("progress_event.zig").ProgressEvent;
const RecordsEvent = @import("records_event.zig").RecordsEvent;
const StatsEvent = @import("stats_event.zig").StatsEvent;

/// The container for selecting objects from a content event stream.
pub const SelectObjectContentEventStream = union(enum) {
    /// The Continuation Event.
    cont: ?ContinuationEvent,
    /// The End Event.
    end: ?EndEvent,
    /// The Progress Event.
    progress: ?ProgressEvent,
    /// The Records Event.
    records: ?RecordsEvent,
    /// The Stats Event.
    stats: ?StatsEvent,
};
