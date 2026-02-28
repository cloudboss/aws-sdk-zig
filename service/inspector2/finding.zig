const CodeVulnerabilityDetails = @import("code_vulnerability_details.zig").CodeVulnerabilityDetails;
const EpssDetails = @import("epss_details.zig").EpssDetails;
const ExploitabilityDetails = @import("exploitability_details.zig").ExploitabilityDetails;
const ExploitAvailable = @import("exploit_available.zig").ExploitAvailable;
const FixAvailable = @import("fix_available.zig").FixAvailable;
const InspectorScoreDetails = @import("inspector_score_details.zig").InspectorScoreDetails;
const NetworkReachabilityDetails = @import("network_reachability_details.zig").NetworkReachabilityDetails;
const PackageVulnerabilityDetails = @import("package_vulnerability_details.zig").PackageVulnerabilityDetails;
const Remediation = @import("remediation.zig").Remediation;
const Resource = @import("resource.zig").Resource;
const Severity = @import("severity.zig").Severity;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const FindingType = @import("finding_type.zig").FindingType;

/// Details about an Amazon Inspector finding.
pub const Finding = struct {
    /// The Amazon Web Services account ID associated with the finding.
    aws_account_id: []const u8,

    /// Details about the code vulnerability identified in a Lambda function used to
    /// filter
    /// findings.
    code_vulnerability_details: ?CodeVulnerabilityDetails,

    /// The description of the finding.
    description: []const u8,

    /// The finding's EPSS score.
    epss: ?EpssDetails,

    /// The details of an exploit available for a finding discovered in your
    /// environment.
    exploitability_details: ?ExploitabilityDetails,

    /// If a finding discovered in your environment has an exploit available.
    exploit_available: ?ExploitAvailable,

    /// The Amazon Resource Number (ARN) of the finding.
    finding_arn: []const u8,

    /// The date and time that the finding was first observed.
    first_observed_at: i64,

    /// Details on whether a fix is available through a version update. This value
    /// can be
    /// `YES`, `NO`, or `PARTIAL`. A `PARTIAL` fix
    /// means that some, but not all, of the packages identified in the finding have
    /// fixes
    /// available through updated versions.
    fix_available: ?FixAvailable,

    /// The Amazon Inspector score given to the finding.
    inspector_score: ?f64,

    /// An object that contains details of the Amazon Inspector score.
    inspector_score_details: ?InspectorScoreDetails,

    /// The date and time the finding was last observed. This timestamp for this
    /// field remains
    /// unchanged until a finding is updated.
    last_observed_at: i64,

    /// An object that contains the details of a network reachability finding.
    network_reachability_details: ?NetworkReachabilityDetails,

    /// An object that contains the details of a package vulnerability finding.
    package_vulnerability_details: ?PackageVulnerabilityDetails,

    /// An object that contains the details about how to remediate a finding.
    remediation: Remediation,

    /// Contains information on the resources involved in a finding. The `resource`
    /// value determines the valid values for `type` in your request. For more
    /// information, see [Finding
    /// types](https://docs.aws.amazon.com/inspector/latest/user/findings-types.html) in the Amazon Inspector user guide.
    resources: []const Resource,

    /// The severity of the finding. `UNTRIAGED` applies to
    /// `PACKAGE_VULNERABILITY` type findings that the vendor has not assigned a
    /// severity yet. For more information, see [Severity levels for
    /// findings](https://docs.aws.amazon.com/inspector/latest/user/findings-understanding-severity.html) in the Amazon Inspector user guide.
    severity: Severity,

    /// The status of the finding.
    status: FindingStatus,

    /// The title of the finding.
    title: ?[]const u8,

    /// The type of the finding. The `type` value determines the valid values for
    /// `resource` in your request. For more information, see [Finding
    /// types](https://docs.aws.amazon.com/inspector/latest/user/findings-types.html) in the Amazon Inspector user guide.
    @"type": FindingType,

    /// The date and time the finding was last updated at.
    updated_at: ?i64,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .code_vulnerability_details = "codeVulnerabilityDetails",
        .description = "description",
        .epss = "epss",
        .exploitability_details = "exploitabilityDetails",
        .exploit_available = "exploitAvailable",
        .finding_arn = "findingArn",
        .first_observed_at = "firstObservedAt",
        .fix_available = "fixAvailable",
        .inspector_score = "inspectorScore",
        .inspector_score_details = "inspectorScoreDetails",
        .last_observed_at = "lastObservedAt",
        .network_reachability_details = "networkReachabilityDetails",
        .package_vulnerability_details = "packageVulnerabilityDetails",
        .remediation = "remediation",
        .resources = "resources",
        .severity = "severity",
        .status = "status",
        .title = "title",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
