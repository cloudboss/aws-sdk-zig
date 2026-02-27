const AppAssessmentScheduleType = @import("app_assessment_schedule_type.zig").AppAssessmentScheduleType;
const AppComplianceStatusType = @import("app_compliance_status_type.zig").AppComplianceStatusType;
const AppDriftStatusType = @import("app_drift_status_type.zig").AppDriftStatusType;
const AppStatusType = @import("app_status_type.zig").AppStatusType;

/// Defines an application summary.
pub const AppSummary = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// Assessment execution schedule with 'Daily' or 'Disabled' values.
    assessment_schedule: ?AppAssessmentScheduleType,

    /// Amazon Resource Name (ARN) of Resource Groups group that is integrated with
    /// an AppRegistry application. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    aws_application_arn: ?[]const u8,

    /// The current status of compliance for the resiliency policy.
    compliance_status: ?AppComplianceStatusType,

    /// Date and time when the app was created.
    creation_time: i64,

    /// The optional description for an app.
    description: ?[]const u8,

    /// Indicates if compliance drifts (deviations) were detected while running an
    /// assessment for
    /// your application.
    drift_status: ?AppDriftStatusType,

    /// Date and time of the most recent compliance evaluation.
    last_app_compliance_evaluation_time: ?i64,

    /// The name of the application.
    name: []const u8,

    /// The current resiliency score for the application.
    resiliency_score: f64 = 0,

    /// Recovery Point Objective (RPO) in seconds.
    rpo_in_secs: ?i32,

    /// Recovery Time Objective (RTO) in seconds.
    rto_in_secs: ?i32,

    /// Status of the application.
    status: ?AppStatusType,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .assessment_schedule = "assessmentSchedule",
        .aws_application_arn = "awsApplicationArn",
        .compliance_status = "complianceStatus",
        .creation_time = "creationTime",
        .description = "description",
        .drift_status = "driftStatus",
        .last_app_compliance_evaluation_time = "lastAppComplianceEvaluationTime",
        .name = "name",
        .resiliency_score = "resiliencyScore",
        .rpo_in_secs = "rpoInSecs",
        .rto_in_secs = "rtoInSecs",
        .status = "status",
    };
};
