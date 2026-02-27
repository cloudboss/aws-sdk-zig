const OptedOutFilterName = @import("opted_out_filter_name.zig").OptedOutFilterName;

/// The information for opted out numbers that meet a specified criteria.
pub const OptedOutFilter = struct {
    /// The name of the attribute to filter on.
    name: OptedOutFilterName,

    /// An array of values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
