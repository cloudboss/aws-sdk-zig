const GroupFilterName = @import("group_filter_name.zig").GroupFilterName;

/// A filter collection that you can use to restrict the results from a `List`
/// operation to only those you want to include.
pub const GroupFilter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: GroupFilterName,

    /// One or more filter values. Allowed filter values vary by group filter name,
    /// and are
    /// case-sensitive.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
