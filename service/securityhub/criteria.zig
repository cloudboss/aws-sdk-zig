const OcsfFindingFilters = @import("ocsf_finding_filters.zig").OcsfFindingFilters;
const ResourcesFilters = @import("resources_filters.zig").ResourcesFilters;

/// Defines the parameters and conditions used to evaluate and filter security
/// findings or resources.
pub const Criteria = union(enum) {
    /// The filtering conditions that align with OCSF standards.
    ocsf_finding_criteria: ?OcsfFindingFilters,
    /// The filtering conditions for resources.
    resource_criteria: ?ResourcesFilters,

    pub const json_field_names = .{
        .ocsf_finding_criteria = "OcsfFindingCriteria",
        .resource_criteria = "ResourceCriteria",
    };
};
