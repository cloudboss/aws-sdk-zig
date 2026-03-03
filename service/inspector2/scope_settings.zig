const ProjectSelectionScope = @import("project_selection_scope.zig").ProjectSelectionScope;

/// Defines the scope of repositories to be included in code security scans.
pub const ScopeSettings = struct {
    /// The scope of projects to be selected for scanning within the integrated
    /// repositories.
    /// Setting the value to `ALL` applies the scope settings to all existing and
    /// future
    /// projects imported into Amazon Inspector.
    project_selection_scope: ?ProjectSelectionScope = null,

    pub const json_field_names = .{
        .project_selection_scope = "projectSelectionScope",
    };
};
