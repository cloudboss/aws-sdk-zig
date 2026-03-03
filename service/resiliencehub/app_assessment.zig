const aws = @import("aws");

const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const DisruptionCompliance = @import("disruption_compliance.zig").DisruptionCompliance;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;
const Cost = @import("cost.zig").Cost;
const DriftStatus = @import("drift_status.zig").DriftStatus;
const AssessmentInvoker = @import("assessment_invoker.zig").AssessmentInvoker;
const ResiliencyPolicy = @import("resiliency_policy.zig").ResiliencyPolicy;
const ResiliencyScore = @import("resiliency_score.zig").ResiliencyScore;
const ResourceErrorsDetails = @import("resource_errors_details.zig").ResourceErrorsDetails;
const AssessmentSummary = @import("assessment_summary.zig").AssessmentSummary;

/// Defines an application assessment.
pub const AppAssessment = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8 = null,

    /// Version of an application.
    app_version: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: []const u8,

    /// Name of the assessment.
    assessment_name: ?[]const u8 = null,

    /// Current status of the assessment for the resiliency policy.
    assessment_status: AssessmentStatus,

    /// Application compliance against the resiliency policy.
    compliance: ?[]const aws.map.MapEntry(DisruptionCompliance) = null,

    /// Current status of the compliance for the resiliency policy.
    compliance_status: ?ComplianceStatus = null,

    /// Cost for the application.
    cost: ?Cost = null,

    /// Indicates if compliance drifts (deviations) were detected while running an
    /// assessment for
    /// your application.
    drift_status: ?DriftStatus = null,

    /// End time for the action.
    end_time: ?i64 = null,

    /// The entity that invoked the assessment.
    invoker: AssessmentInvoker,

    /// Error or warning message from the assessment execution
    message: ?[]const u8 = null,

    /// Resiliency policy of an application.
    policy: ?ResiliencyPolicy = null,

    /// Current resiliency score for an application.
    resiliency_score: ?ResiliencyScore = null,

    /// A resource error object containing a list of errors retrieving an
    /// application's
    /// resources.
    resource_errors_details: ?ResourceErrorsDetails = null,

    /// Starting time for the action.
    start_time: ?i64 = null,

    /// Indicates the AI-generated summary for the Resilience Hub assessment,
    /// providing a concise overview that highlights the top risks and
    /// recommendations.
    ///
    /// This property is available only in the US East (N. Virginia) Region.
    summary: ?AssessmentSummary = null,

    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Version name of the published application.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .assessment_arn = "assessmentArn",
        .assessment_name = "assessmentName",
        .assessment_status = "assessmentStatus",
        .compliance = "compliance",
        .compliance_status = "complianceStatus",
        .cost = "cost",
        .drift_status = "driftStatus",
        .end_time = "endTime",
        .invoker = "invoker",
        .message = "message",
        .policy = "policy",
        .resiliency_score = "resiliencyScore",
        .resource_errors_details = "resourceErrorsDetails",
        .start_time = "startTime",
        .summary = "summary",
        .tags = "tags",
        .version_name = "versionName",
    };
};
