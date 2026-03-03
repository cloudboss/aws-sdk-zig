const PatchComplianceLevel = @import("patch_compliance_level.zig").PatchComplianceLevel;
const PatchDeploymentStatus = @import("patch_deployment_status.zig").PatchDeploymentStatus;

/// Information about the approval status of a patch.
pub const PatchStatus = struct {
    /// The date the patch was approved (or will be approved if the status is
    /// `PENDING_APPROVAL`).
    approval_date: ?i64 = null,

    /// The compliance severity level for a patch.
    compliance_level: ?PatchComplianceLevel = null,

    /// The approval status of a patch.
    deployment_status: ?PatchDeploymentStatus = null,

    pub const json_field_names = .{
        .approval_date = "ApprovalDate",
        .compliance_level = "ComplianceLevel",
        .deployment_status = "DeploymentStatus",
    };
};
