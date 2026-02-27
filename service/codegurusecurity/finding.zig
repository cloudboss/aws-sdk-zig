const Remediation = @import("remediation.zig").Remediation;
const Resource = @import("resource.zig").Resource;
const Severity = @import("severity.zig").Severity;
const Status = @import("status.zig").Status;
const Vulnerability = @import("vulnerability.zig").Vulnerability;

/// Information about a finding that was detected in your code.
pub const Finding = struct {
    /// The time when the finding was created.
    created_at: ?i64,

    /// A description of the finding.
    description: ?[]const u8,

    /// The identifier for the detector that detected the finding in your code. A
    /// detector is a defined rule based on industry standards and AWS best
    /// practices.
    detector_id: ?[]const u8,

    /// The name of the detector that identified the security vulnerability in your
    /// code.
    detector_name: ?[]const u8,

    /// One or more tags or categorizations that are associated with a detector.
    /// These tags are defined by type, programming language, or other
    /// classification such as maintainability or consistency.
    detector_tags: ?[]const []const u8,

    /// The identifier for the component that generated a finding such as
    /// AmazonCodeGuruSecurity.
    generator_id: ?[]const u8,

    /// The identifier for a finding.
    id: ?[]const u8,

    /// An object that contains the details about how to remediate a finding.
    remediation: ?Remediation,

    /// The resource where Amazon CodeGuru Security detected a finding.
    resource: ?Resource,

    /// The identifier for the rule that generated the finding.
    rule_id: ?[]const u8,

    /// The severity of the finding. Severity can be critical, high, medium, low, or
    /// informational. For information on severity levels, see [Finding
    /// severity](https://docs.aws.amazon.com/codeguru/latest/security-ug/findings-overview.html#severity-distribution) in the *Amazon CodeGuru Security User Guide*.
    severity: ?Severity,

    /// The status of the finding. A finding status can be open or closed.
    status: ?Status,

    /// The title of the finding.
    title: ?[]const u8,

    /// The type of finding.
    type: ?[]const u8,

    /// The time when the finding was last updated. Findings are updated when you
    /// remediate them or when the finding code location changes.
    updated_at: ?i64,

    /// An object that describes the detected security vulnerability.
    vulnerability: ?Vulnerability,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .detector_id = "detectorId",
        .detector_name = "detectorName",
        .detector_tags = "detectorTags",
        .generator_id = "generatorId",
        .id = "id",
        .remediation = "remediation",
        .resource = "resource",
        .rule_id = "ruleId",
        .severity = "severity",
        .status = "status",
        .title = "title",
        .type = "type",
        .updated_at = "updatedAt",
        .vulnerability = "vulnerability",
    };
};
