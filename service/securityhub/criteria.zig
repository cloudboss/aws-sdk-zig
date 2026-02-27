const OcsfFindingFilters = @import("ocsf_finding_filters.zig").OcsfFindingFilters;

/// Defines the parameters and conditions used to evaluate and filter security
/// findings.
pub const Criteria = union(enum) {
    /// The filtering conditions that align with OCSF standards.
    ocsf_finding_criteria: ?OcsfFindingFilters,

    pub const json_field_names = .{
        .ocsf_finding_criteria = "OcsfFindingCriteria",
    };
};
