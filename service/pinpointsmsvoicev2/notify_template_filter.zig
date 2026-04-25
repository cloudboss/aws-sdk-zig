const NotifyTemplateFilterName = @import("notify_template_filter_name.zig").NotifyTemplateFilterName;

/// The information for notify templates that meet a specified criteria.
pub const NotifyTemplateFilter = struct {
    /// The name of the attribute to filter on.
    name: NotifyTemplateFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
