const EventDataSource = @import("event_data_source.zig").EventDataSource;
const EventClass = @import("event_class.zig").EventClass;
const EventTimeRange = @import("event_time_range.zig").EventTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;

/// Filters you can use to specify which events are returned when `ListEvents`
/// is called.
pub const ListEventsFilters = struct {
    /// The source, `AWS_CLOUD_TRAIL` or `AWS_CODE_DEPLOY`, of the
    /// events you want returned.
    data_source: ?EventDataSource = null,

    /// The class of the events you want to filter for, such as an infrastructure
    /// change, a
    /// deployment, or a schema change.
    event_class: ?EventClass = null,

    /// The Amazon Web Services source that emitted the events you want to filter
    /// for.
    event_source: ?[]const u8 = null,

    /// A time range during which you want the filtered events to have occurred.
    event_time_range: ?EventTimeRange = null,

    /// An ID of an insight that is related to the events you want to filter for.
    insight_id: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .event_class = "EventClass",
        .event_source = "EventSource",
        .event_time_range = "EventTimeRange",
        .insight_id = "InsightId",
        .resource_collection = "ResourceCollection",
    };
};
