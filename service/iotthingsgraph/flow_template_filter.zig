const FlowTemplateFilterName = @import("flow_template_filter_name.zig").FlowTemplateFilterName;

/// An object that filters a workflow search.
pub const FlowTemplateFilter = struct {
    /// The name of the search filter field.
    name: FlowTemplateFilterName,

    /// An array of string values for the search filter field. Multiple values
    /// function as AND criteria in the search.
    value: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
