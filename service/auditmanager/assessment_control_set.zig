const AssessmentControl = @import("assessment_control.zig").AssessmentControl;
const Delegation = @import("delegation.zig").Delegation;
const Role = @import("role.zig").Role;
const ControlSetStatus = @import("control_set_status.zig").ControlSetStatus;

/// Represents a set of controls in an Audit Manager assessment.
pub const AssessmentControlSet = struct {
    /// The list of controls that's contained with the control set.
    controls: ?[]const AssessmentControl,

    /// The delegations that are associated with the control set.
    delegations: ?[]const Delegation,

    /// The description for the control set.
    description: ?[]const u8,

    /// The identifier of the control set in the assessment. This is the control set
    /// name in a
    /// plain string format.
    id: ?[]const u8,

    /// The total number of evidence objects that are uploaded manually to the
    /// control set.
    manual_evidence_count: i32 = 0,

    /// The roles that are associated with the control set.
    roles: ?[]const Role,

    /// The current status of the control set.
    status: ?ControlSetStatus,

    /// The total number of evidence objects that are retrieved automatically for
    /// the control
    /// set.
    system_evidence_count: i32 = 0,

    pub const json_field_names = .{
        .controls = "controls",
        .delegations = "delegations",
        .description = "description",
        .id = "id",
        .manual_evidence_count = "manualEvidenceCount",
        .roles = "roles",
        .status = "status",
        .system_evidence_count = "systemEvidenceCount",
    };
};
