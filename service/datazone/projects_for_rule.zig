const RuleScopeSelectionMode = @import("rule_scope_selection_mode.zig").RuleScopeSelectionMode;

/// Specifies projects in which the rule is created.
pub const ProjectsForRule = struct {
    /// The selection mode of the rule.
    selection_mode: RuleScopeSelectionMode,

    /// The specific projects in which the rule is created.
    specific_projects: ?[]const []const u8,

    pub const json_field_names = .{
        .selection_mode = "selectionMode",
        .specific_projects = "specificProjects",
    };
};
