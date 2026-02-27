const ListEventTypesFilterName = @import("list_event_types_filter_name.zig").ListEventTypesFilterName;

/// Information about a filter to apply to the list of returned event types. You
/// can filter
/// by resource type or service name.
pub const ListEventTypesFilter = struct {
    /// The system-generated name of the filter type you want to filter by.
    name: ListEventTypesFilterName,

    /// The name of the resource type (for example, pipeline) or service name (for
    /// example,
    /// CodePipeline) that you want to filter by.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
