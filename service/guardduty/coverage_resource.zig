const CoverageStatus = @import("coverage_status.zig").CoverageStatus;
const CoverageResourceDetails = @import("coverage_resource_details.zig").CoverageResourceDetails;

/// Information about the resource of the GuardDuty account.
pub const CoverageResource = struct {
    /// The unique ID of the Amazon Web Services account.
    account_id: ?[]const u8,

    /// Represents the status of the EKS cluster coverage.
    coverage_status: ?CoverageStatus,

    /// The unique ID of the GuardDuty detector associated with the resource.
    detector_id: ?[]const u8,

    /// Represents the reason why a coverage status was `UNHEALTHY` for the EKS
    /// cluster.
    issue: ?[]const u8,

    /// Information about the resource for which the coverage statistics are
    /// retrieved.
    resource_details: ?CoverageResourceDetails,

    /// The unique ID of the resource.
    resource_id: ?[]const u8,

    /// The timestamp at which the coverage details for the resource were last
    /// updated. This is in
    /// UTC format.
    updated_at: ?i64,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .coverage_status = "CoverageStatus",
        .detector_id = "DetectorId",
        .issue = "Issue",
        .resource_details = "ResourceDetails",
        .resource_id = "ResourceId",
        .updated_at = "UpdatedAt",
    };
};
