const PackageVulnerabilityDetails = @import("package_vulnerability_details.zig").PackageVulnerabilityDetails;
const Remediation = @import("remediation.zig").Remediation;
const Resource = @import("resource.zig").Resource;
const ScoreDetails = @import("score_details.zig").ScoreDetails;

/// The details of an enhanced image scan. This is returned when enhanced
/// scanning is
/// enabled for your private registry.
pub const EnhancedImageScanFinding = struct {
    /// The Amazon Web Services account ID associated with the image.
    aws_account_id: ?[]const u8,

    /// The description of the finding.
    description: ?[]const u8,

    /// If a finding discovered in your environment has an exploit available.
    exploit_available: ?[]const u8,

    /// The Amazon Resource Number (ARN) of the finding.
    finding_arn: ?[]const u8,

    /// The date and time that the finding was first observed.
    first_observed_at: ?i64,

    /// Details on whether a fix is available through a version update. This value
    /// can be
    /// `YES`, `NO`, or `PARTIAL`. A `PARTIAL`
    /// fix means that some, but not all, of the packages identified in the finding
    /// have fixes
    /// available through updated versions.
    fix_available: ?[]const u8,

    /// The date and time that the finding was last observed.
    last_observed_at: ?i64,

    /// An object that contains the details of a package vulnerability finding.
    package_vulnerability_details: ?PackageVulnerabilityDetails,

    /// An object that contains the details about how to remediate a finding.
    remediation: ?Remediation,

    /// Contains information on the resources involved in a finding.
    resources: ?[]const Resource,

    /// The Amazon Inspector score given to the finding.
    score: f64 = 0,

    /// An object that contains details of the Amazon Inspector score.
    score_details: ?ScoreDetails,

    /// The severity of the finding.
    severity: ?[]const u8,

    /// The status of the finding.
    status: ?[]const u8,

    /// The title of the finding.
    title: ?[]const u8,

    /// The type of the finding.
    type: ?[]const u8,

    /// The date and time the finding was last updated at.
    updated_at: ?i64,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .description = "description",
        .exploit_available = "exploitAvailable",
        .finding_arn = "findingArn",
        .first_observed_at = "firstObservedAt",
        .fix_available = "fixAvailable",
        .last_observed_at = "lastObservedAt",
        .package_vulnerability_details = "packageVulnerabilityDetails",
        .remediation = "remediation",
        .resources = "resources",
        .score = "score",
        .score_details = "scoreDetails",
        .severity = "severity",
        .status = "status",
        .title = "title",
        .type = "type",
        .updated_at = "updatedAt",
    };
};
