const aws = @import("aws");

const RemediationIssueDetails = @import("remediation_issue_details.zig").RemediationIssueDetails;
const NotVisibleMarker = @import("not_visible_marker.zig").NotVisibleMarker;

/// Remediation issue details for a resource, or a marker indicating that the
/// details are not visible. Exactly one member is set.
pub const RemediationIssuesView = union(enum) {
    /// The remediation issues, keyed by firewall type.
    issues: ?[]const aws.map.MapEntry(RemediationIssueDetails),
    /// Indicates that the details are not visible because of cross-account
    /// restrictions.
    not_visible: ?NotVisibleMarker,

    pub const json_field_names = .{
        .issues = "issues",
        .not_visible = "notVisible",
    };
};
