const DomainUnitFilterForProject = @import("domain_unit_filter_for_project.zig").DomainUnitFilterForProject;

/// The project grant filter.
pub const ProjectGrantFilter = union(enum) {
    /// The domain unit filter of the project grant filter.
    domain_unit_filter: ?DomainUnitFilterForProject,

    pub const json_field_names = .{
        .domain_unit_filter = "domainUnitFilter",
    };
};
