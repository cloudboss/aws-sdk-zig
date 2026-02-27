/// Event filter allows you to focus on specific events in an operation.
pub const EventFilter = struct {
    /// When set to true, only returns failed events within the operation. This
    /// helps quickly
    /// identify root causes for a failed operation.
    failed_events: ?bool,
};
