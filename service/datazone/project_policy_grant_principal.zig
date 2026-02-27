const ProjectDesignation = @import("project_designation.zig").ProjectDesignation;
const ProjectGrantFilter = @import("project_grant_filter.zig").ProjectGrantFilter;

/// The project policy grant principal.
pub const ProjectPolicyGrantPrincipal = struct {
    /// The project designation of the project policy grant principal.
    project_designation: ProjectDesignation,

    /// The project grant filter of the project policy grant principal.
    project_grant_filter: ?ProjectGrantFilter,

    /// The project ID of the project policy grant principal.
    project_identifier: ?[]const u8,

    pub const json_field_names = .{
        .project_designation = "projectDesignation",
        .project_grant_filter = "projectGrantFilter",
        .project_identifier = "projectIdentifier",
    };
};
