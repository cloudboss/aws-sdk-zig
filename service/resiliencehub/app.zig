const aws = @import("aws");

const AppAssessmentScheduleType = @import("app_assessment_schedule_type.zig").AppAssessmentScheduleType;
const AppComplianceStatusType = @import("app_compliance_status_type.zig").AppComplianceStatusType;
const AppDriftStatusType = @import("app_drift_status_type.zig").AppDriftStatusType;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const PermissionModel = @import("permission_model.zig").PermissionModel;
const AppStatusType = @import("app_status_type.zig").AppStatusType;

/// Defines an Resilience Hub application.
pub const App = struct {
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
    assessment_schedule: ?AppAssessmentScheduleType = null,

    /// Amazon Resource Name (ARN) of Resource Groups group that is integrated with
    /// an AppRegistry application. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    aws_application_arn: ?[]const u8 = null,

    /// Current status of compliance for the resiliency policy.
    compliance_status: ?AppComplianceStatusType = null,

    /// Date and time when the application was created.
    creation_time: i64,

    /// Optional description for an application.
    description: ?[]const u8 = null,

    /// Indicates if compliance drifts (deviations) were detected while running an
    /// assessment for
    /// your application.
    drift_status: ?AppDriftStatusType = null,

    /// The list of events you would like to subscribe and get notification for.
    /// Currently,
    /// Resilience Hub supports notifications only for **Drift
    /// detected** and **Scheduled assessment failure**
    /// events.
    event_subscriptions: ?[]const EventSubscription = null,

    /// Date and time the most recent compliance evaluation.
    last_app_compliance_evaluation_time: ?i64 = null,

    /// Indicates the last time that a drift was evaluated.
    last_drift_evaluation_time: ?i64 = null,

    /// Date and time the most recent resiliency score evaluation.
    last_resiliency_score_evaluation_time: ?i64 = null,

    /// Name for the application.
    name: []const u8,

    /// Defines the roles and credentials that Resilience Hub would use while
    /// creating the
    /// application, importing its resources, and running an assessment.
    permission_model: ?PermissionModel = null,

    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: ?[]const u8 = null,

    /// Current resiliency score for the application.
    resiliency_score: f64 = 0,

    /// Recovery Point Objective (RPO) in seconds.
    rpo_in_secs: ?i32 = null,

    /// Recovery Time Objective (RTO) in seconds.
    rto_in_secs: ?i32 = null,

    /// Status of the application.
    status: ?AppStatusType = null,

    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .assessment_schedule = "assessmentSchedule",
        .aws_application_arn = "awsApplicationArn",
        .compliance_status = "complianceStatus",
        .creation_time = "creationTime",
        .description = "description",
        .drift_status = "driftStatus",
        .event_subscriptions = "eventSubscriptions",
        .last_app_compliance_evaluation_time = "lastAppComplianceEvaluationTime",
        .last_drift_evaluation_time = "lastDriftEvaluationTime",
        .last_resiliency_score_evaluation_time = "lastResiliencyScoreEvaluationTime",
        .name = "name",
        .permission_model = "permissionModel",
        .policy_arn = "policyArn",
        .resiliency_score = "resiliencyScore",
        .rpo_in_secs = "rpoInSecs",
        .rto_in_secs = "rtoInSecs",
        .status = "status",
        .tags = "tags",
    };
};
