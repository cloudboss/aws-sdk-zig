const CaseSlaConfiguration = @import("case_sla_configuration.zig").CaseSlaConfiguration;
const SlaAssignmentType = @import("sla_assignment_type.zig").SlaAssignmentType;

/// The AssignSla action definition.
pub const AssignSlaActionDefinition = struct {
    /// The SLA configuration for Case SLA Assignment.
    case_sla_configuration: ?CaseSlaConfiguration,

    /// Type of SLA assignment.
    sla_assignment_type: SlaAssignmentType,

    pub const json_field_names = .{
        .case_sla_configuration = "CaseSlaConfiguration",
        .sla_assignment_type = "SlaAssignmentType",
    };
};
