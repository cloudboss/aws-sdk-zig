const DashboardSourceTemplate = @import("dashboard_source_template.zig").DashboardSourceTemplate;

/// Dashboard source entity.
pub const DashboardSourceEntity = struct {
    /// Source template.
    source_template: ?DashboardSourceTemplate = null,

    pub const json_field_names = .{
        .source_template = "SourceTemplate",
    };
};
