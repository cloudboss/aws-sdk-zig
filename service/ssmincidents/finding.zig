const FindingDetails = @import("finding_details.zig").FindingDetails;

/// Information about a specific CodeDeploy deployment or CloudFormation
/// stack creation or update that occurred around the time of a reported
/// incident. These
/// activities can be investigated as a potential cause of the incident.
pub const Finding = struct {
    /// The timestamp for when a finding was created.
    creation_time: i64,

    /// Details about the finding.
    details: ?FindingDetails,

    /// The ID assigned to the finding.
    id: []const u8,

    /// The timestamp for when the finding was most recently updated with additional
    /// information.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .details = "details",
        .id = "id",
        .last_modified_time = "lastModifiedTime",
    };
};
