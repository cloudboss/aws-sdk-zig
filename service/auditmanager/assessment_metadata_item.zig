const Delegation = @import("delegation.zig").Delegation;
const Role = @import("role.zig").Role;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;

/// A metadata object that's associated with an assessment in Audit Manager.
pub const AssessmentMetadataItem = struct {
    /// The name of the compliance standard that's related to the assessment, such
    /// as PCI-DSS.
    compliance_type: ?[]const u8,

    /// Specifies when the assessment was created.
    creation_time: ?i64,

    /// The delegations that are associated with the assessment.
    delegations: ?[]const Delegation,

    /// The unique identifier for the assessment.
    id: ?[]const u8,

    /// The time of the most recent update.
    last_updated: ?i64,

    /// The name of the assessment.
    name: ?[]const u8,

    /// The roles that are associated with the assessment.
    roles: ?[]const Role,

    /// The current status of the assessment.
    status: ?AssessmentStatus,

    pub const json_field_names = .{
        .compliance_type = "complianceType",
        .creation_time = "creationTime",
        .delegations = "delegations",
        .id = "id",
        .last_updated = "lastUpdated",
        .name = "name",
        .roles = "roles",
        .status = "status",
    };
};
