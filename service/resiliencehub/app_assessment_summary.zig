const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;
const Cost = @import("cost.zig").Cost;
const DriftStatus = @import("drift_status.zig").DriftStatus;
const AssessmentInvoker = @import("assessment_invoker.zig").AssessmentInvoker;

/// Defines an application assessment summary.
pub const AppAssessmentSummary = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8,

    /// Version of an application.
    app_version: ?[]const u8,

    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: []const u8,

    /// Name of the assessment.
    assessment_name: ?[]const u8,

    /// Current status of the assessment for the resiliency policy.
    assessment_status: AssessmentStatus,

    /// Current status of compliance for the resiliency policy.
    compliance_status: ?ComplianceStatus,

    /// Cost for an application.
    cost: ?Cost,

    /// Indicates if compliance drifts (deviations) were detected while running an
    /// assessment for
    /// your application.
    drift_status: ?DriftStatus,

    /// End time for the action.
    end_time: ?i64,

    /// Entity that invoked the assessment.
    invoker: ?AssessmentInvoker,

    /// Message from the assessment run.
    message: ?[]const u8,

    /// Current resiliency score for the application.
    resiliency_score: f64 = 0,

    /// Starting time for the action.
    start_time: ?i64,

    /// Name of an application version.
    version_name: ?[]const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .assessment_arn = "assessmentArn",
        .assessment_name = "assessmentName",
        .assessment_status = "assessmentStatus",
        .compliance_status = "complianceStatus",
        .cost = "cost",
        .drift_status = "driftStatus",
        .end_time = "endTime",
        .invoker = "invoker",
        .message = "message",
        .resiliency_score = "resiliencyScore",
        .start_time = "startTime",
        .version_name = "versionName",
    };
};
