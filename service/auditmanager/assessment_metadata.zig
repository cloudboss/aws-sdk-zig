const AssessmentReportsDestination = @import("assessment_reports_destination.zig").AssessmentReportsDestination;
const Delegation = @import("delegation.zig").Delegation;
const Role = @import("role.zig").Role;
const Scope = @import("scope.zig").Scope;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;

/// The metadata that's associated with the specified assessment.
pub const AssessmentMetadata = struct {
    /// The destination that evidence reports are stored in for the assessment.
    assessment_reports_destination: ?AssessmentReportsDestination,

    /// The name of the compliance standard that's related to the assessment, such
    /// as PCI-DSS.
    compliance_type: ?[]const u8,

    /// Specifies when the assessment was created.
    creation_time: ?i64,

    /// The delegations that are associated with the assessment.
    delegations: ?[]const Delegation,

    /// The description of the assessment.
    description: ?[]const u8,

    /// The unique identifier for the assessment.
    id: ?[]const u8,

    /// The time of the most recent update.
    last_updated: ?i64,

    /// The name of the assessment.
    name: ?[]const u8,

    /// The roles that are associated with the assessment.
    roles: ?[]const Role,

    /// The wrapper of Amazon Web Services accounts and services that are in scope
    /// for the
    /// assessment.
    scope: ?Scope,

    /// The overall status of the assessment.
    status: ?AssessmentStatus,

    pub const json_field_names = .{
        .assessment_reports_destination = "assessmentReportsDestination",
        .compliance_type = "complianceType",
        .creation_time = "creationTime",
        .delegations = "delegations",
        .description = "description",
        .id = "id",
        .last_updated = "lastUpdated",
        .name = "name",
        .roles = "roles",
        .scope = "scope",
        .status = "status",
    };
};
