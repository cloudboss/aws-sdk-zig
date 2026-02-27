const OpenLineageRunEventSummary = @import("open_lineage_run_event_summary.zig").OpenLineageRunEventSummary;

/// The event summary.
pub const EventSummary = union(enum) {
    /// The open lineage run event summary.
    open_lineage_run_event_summary: ?OpenLineageRunEventSummary,

    pub const json_field_names = .{
        .open_lineage_run_event_summary = "openLineageRunEventSummary",
    };
};
