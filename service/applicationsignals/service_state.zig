const aws = @import("aws");

const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const ChangeEvent = @import("change_event.zig").ChangeEvent;

/// A structure that contains information about the current state of a service,
/// including its latest change events such as deployments and other
/// state-changing activities.
pub const ServiceState = struct {
    /// The attribute filters that were applied when retrieving this service state
    /// information.
    attribute_filters: ?[]const AttributeFilter,

    /// An array containing the most recent change events for this service, such as
    /// deployments, with information about when they occurred and who initiated
    /// them.
    latest_change_events: []const ChangeEvent,

    /// The key attributes that identify this service, including Type, Name, and
    /// Environment information.
    service: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .attribute_filters = "AttributeFilters",
        .latest_change_events = "LatestChangeEvents",
        .service = "Service",
    };
};
