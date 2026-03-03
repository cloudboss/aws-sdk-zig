const aws = @import("aws");

const AssessmentRunNotification = @import("assessment_run_notification.zig").AssessmentRunNotification;
const AssessmentRunState = @import("assessment_run_state.zig").AssessmentRunState;
const AssessmentRunStateChange = @import("assessment_run_state_change.zig").AssessmentRunStateChange;
const Attribute = @import("attribute.zig").Attribute;

/// A snapshot of an Amazon Inspector assessment run that contains the findings
/// of the
/// assessment run .
///
/// Used as the response element in the DescribeAssessmentRuns
/// action.
pub const AssessmentRun = struct {
    /// The ARN of the assessment run.
    arn: []const u8,

    /// The ARN of the assessment template that is associated with the assessment
    /// run.
    assessment_template_arn: []const u8,

    /// The assessment run completion time that corresponds to the rules packages
    /// evaluation
    /// completion time or failure.
    completed_at: ?i64 = null,

    /// The time when StartAssessmentRun was called.
    created_at: i64,

    /// A Boolean value (true or false) that specifies whether the process of
    /// collecting data
    /// from the agents is completed.
    data_collected: bool,

    /// The duration of the assessment run.
    duration_in_seconds: i32,

    /// Provides a total count of generated findings per severity.
    finding_counts: []const aws.map.MapEntry(i32),

    /// The auto-generated name for the assessment run.
    name: []const u8,

    /// A list of notifications for the event subscriptions. A notification about a
    /// particular generated finding is added to this list only once.
    notifications: []const AssessmentRunNotification,

    /// The rules packages selected for the assessment run.
    rules_package_arns: []const []const u8,

    /// The time when StartAssessmentRun was called.
    started_at: ?i64 = null,

    /// The state of the assessment run.
    state: AssessmentRunState,

    /// The last time when the assessment run's state changed.
    state_changed_at: i64,

    /// A list of the assessment run state changes.
    state_changes: []const AssessmentRunStateChange,

    /// The user-defined attributes that are assigned to every generated finding.
    user_attributes_for_findings: []const Attribute,

    pub const json_field_names = .{
        .arn = "arn",
        .assessment_template_arn = "assessmentTemplateArn",
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .data_collected = "dataCollected",
        .duration_in_seconds = "durationInSeconds",
        .finding_counts = "findingCounts",
        .name = "name",
        .notifications = "notifications",
        .rules_package_arns = "rulesPackageArns",
        .started_at = "startedAt",
        .state = "state",
        .state_changed_at = "stateChangedAt",
        .state_changes = "stateChanges",
        .user_attributes_for_findings = "userAttributesForFindings",
    };
};
