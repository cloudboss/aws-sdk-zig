const EventDataSource = @import("event_data_source.zig").EventDataSource;
const EventClass = @import("event_class.zig").EventClass;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const EventResource = @import("event_resource.zig").EventResource;

/// An Amazon Web Services resource event. Amazon Web Services resource events
/// and metrics are analyzed by DevOps Guru to
/// find anomalous behavior and provide recommendations to improve your
/// operational
/// solutions.
pub const Event = struct {
    /// The source, `AWS_CLOUD_TRAIL` or `AWS_CODE_DEPLOY`, where DevOps Guru
    /// analysis found the event.
    data_source: ?EventDataSource = null,

    /// The class of the event. The class specifies what the event is related to,
    /// such as an
    /// infrastructure change, a deployment, or a schema change.
    event_class: ?EventClass = null,

    /// The Amazon Web Services source that emitted the event.
    event_source: ?[]const u8 = null,

    /// The ID of the event.
    id: ?[]const u8 = null,

    /// The name of the event.
    name: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    /// An `EventResource` object that contains information about the resource
    /// that emitted the event.
    resources: ?[]const EventResource = null,

    /// A `Timestamp` that specifies the time the event occurred.
    time: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .event_class = "EventClass",
        .event_source = "EventSource",
        .id = "Id",
        .name = "Name",
        .resource_collection = "ResourceCollection",
        .resources = "Resources",
        .time = "Time",
    };
};
