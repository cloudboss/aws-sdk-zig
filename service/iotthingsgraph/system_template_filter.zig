const SystemTemplateFilterName = @import("system_template_filter_name.zig").SystemTemplateFilterName;

/// An object that filters a system search.
pub const SystemTemplateFilter = struct {
    /// The name of the system search filter field.
    name: SystemTemplateFilterName,

    /// An array of string values for the search filter field. Multiple values
    /// function as AND criteria in the search.
    value: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
