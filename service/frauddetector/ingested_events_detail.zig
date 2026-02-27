const IngestedEventsTimeWindow = @import("ingested_events_time_window.zig").IngestedEventsTimeWindow;

/// The details of the ingested event.
pub const IngestedEventsDetail = struct {
    /// The start and stop time of the ingested events.
    ingested_events_time_window: IngestedEventsTimeWindow,

    pub const json_field_names = .{
        .ingested_events_time_window = "ingestedEventsTimeWindow",
    };
};
