const InspectorScoreDetails = @import("inspector_score_details.zig").InspectorScoreDetails;
const PackageVulnerabilityDetails = @import("package_vulnerability_details.zig").PackageVulnerabilityDetails;
const Remediation = @import("remediation.zig").Remediation;

/// Contains details about a vulnerability scan finding.
pub const ImageScanFinding = struct {
    /// The Amazon Web Services account ID that's associated with the finding.
    aws_account_id: ?[]const u8 = null,

    /// The description of the finding.
    description: ?[]const u8 = null,

    /// The date and time when the finding was first observed.
    first_observed_at: ?i64 = null,

    /// Details about whether a fix is available for any of the packages that are
    /// identified
    /// in the finding through a version update.
    fix_available: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image build version that's associated
    /// with the
    /// finding.
    image_build_version_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image pipeline that's associated with
    /// the
    /// finding.
    image_pipeline_arn: ?[]const u8 = null,

    /// The score that Amazon Inspector assigned for the finding.
    inspector_score: ?f64 = null,

    /// An object that contains details of the Amazon Inspector score.
    inspector_score_details: ?InspectorScoreDetails = null,

    /// An object that contains the details of a package vulnerability finding.
    package_vulnerability_details: ?PackageVulnerabilityDetails = null,

    /// An object that contains the details about how to remediate the finding.
    remediation: ?Remediation = null,

    /// The severity of the finding.
    severity: ?[]const u8 = null,

    /// The title of the finding.
    title: ?[]const u8 = null,

    /// The type of the finding. Image Builder looks for findings of the type
    /// `PACKAGE_VULNERABILITY` that apply to output images, and excludes other
    /// types.
    @"type": ?[]const u8 = null,

    /// The timestamp when the finding was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .description = "description",
        .first_observed_at = "firstObservedAt",
        .fix_available = "fixAvailable",
        .image_build_version_arn = "imageBuildVersionArn",
        .image_pipeline_arn = "imagePipelineArn",
        .inspector_score = "inspectorScore",
        .inspector_score_details = "inspectorScoreDetails",
        .package_vulnerability_details = "packageVulnerabilityDetails",
        .remediation = "remediation",
        .severity = "severity",
        .title = "title",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
