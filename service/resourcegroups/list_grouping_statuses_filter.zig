const ListGroupingStatusesFilterName = @import("list_grouping_statuses_filter_name.zig").ListGroupingStatusesFilterName;

/// A filter name and value pair that is used to obtain more specific results
/// from the list of grouping statuses.
pub const ListGroupingStatusesFilter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: ListGroupingStatusesFilterName,

    /// One or more filter values. Allowed filter values vary by resource filter
    /// name, and are case-sensitive.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
