const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AssociationComplianceSeverity = @import("association_compliance_severity.zig").AssociationComplianceSeverity;
const InstanceAssociationOutputLocation = @import("instance_association_output_location.zig").InstanceAssociationOutputLocation;
const AssociationSyncCompliance = @import("association_sync_compliance.zig").AssociationSyncCompliance;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;

/// Describes the association of a Amazon Web Services Systems Manager document
/// (SSM document) and a managed node.
pub const CreateAssociationBatchRequestEntry = struct {
    alarm_configuration: ?AlarmConfiguration,

    /// By default, when you create a new association, the system runs it
    /// immediately after it is
    /// created and then according to the schedule you specified and when target
    /// changes are detected.
    /// Specify `true` for `ApplyOnlyAtCronInterval` if you want the association to
    /// run only according to the schedule you specified.
    ///
    /// For more information, see [Understanding when associations are applied to
    /// resources](https://docs.aws.amazon.com/systems-manager/latest/userguide/state-manager-about.html#state-manager-about-scheduling) and [>About
    /// target updates with Automation
    /// runbooks](https://docs.aws.amazon.com/systems-manager/latest/userguide/state-manager-about.html#runbook-target-updates) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// This parameter isn't supported for rate expressions.
    apply_only_at_cron_interval: ?bool,

    /// Specify a descriptive name for the association.
    association_name: ?[]const u8,

    /// Specify the target for the association. This target is required for
    /// associations that use an
    /// Automation runbook and target resources by using rate controls. Automation
    /// is a tool in
    /// Amazon Web Services Systems Manager.
    automation_target_parameter_name: ?[]const u8,

    /// The names or Amazon Resource Names (ARNs) of the Change Calendar type
    /// documents your
    /// associations are gated under. The associations only run when that Change
    /// Calendar is open. For
    /// more information, see [Amazon Web Services Systems Manager Change
    /// Calendar](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar) in the *Amazon Web Services Systems Manager User Guide*.
    calendar_names: ?[]const []const u8,

    /// The severity level to assign to the association.
    compliance_severity: ?AssociationComplianceSeverity,

    /// The document version.
    document_version: ?[]const u8,

    /// The number of hours the association can run before it is canceled. Duration
    /// applies to
    /// associations that are currently running, and any pending and in progress
    /// commands on all targets.
    /// If a target was taken offline for the association to run, it is made
    /// available again immediately,
    /// without a reboot.
    ///
    /// The `Duration` parameter applies only when both these conditions are true:
    ///
    /// * The association for which you specify a duration is cancelable according
    ///   to the parameters
    /// of the SSM command document or Automation runbook associated with this
    /// execution.
    ///
    /// * The command specifies the `
    /// [ApplyOnlyAtCronInterval](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_CreateAssociationBatchRequestEntry.html#systemsmanager-Type-CreateAssociationBatchRequestEntry-ApplyOnlyAtCronInterval)
    /// ` parameter, which means that the association doesn't
    /// run immediately after it is created, but only according to the specified
    /// schedule.
    duration: ?i32,

    /// The managed node ID.
    ///
    /// `InstanceId` has been deprecated. To specify a managed node ID for an
    /// association, use the `Targets` parameter. Requests that
    /// include the parameter `InstanceID` with Systems Manager documents (SSM
    /// documents) that use
    /// schema version 2.0 or later will fail. In addition, if you use the
    /// parameter `InstanceId`, you can't use the parameters `AssociationName`,
    /// `DocumentVersion`, `MaxErrors`, `MaxConcurrency`,
    /// `OutputLocation`, or `ScheduleExpression`. To use these parameters, you
    /// must use the `Targets` parameter.
    instance_id: ?[]const u8,

    /// The maximum number of targets allowed to run the association at the same
    /// time. You can
    /// specify a number, for example 10, or a percentage of the target set, for
    /// example 10%. The default
    /// value is 100%, which means all targets run the association at the same time.
    ///
    /// If a new managed node starts and attempts to run an association while
    /// Systems Manager is running
    /// `MaxConcurrency` associations, the association is allowed to run. During the
    /// next
    /// association interval, the new managed node will process its association
    /// within the limit
    /// specified for `MaxConcurrency`.
    max_concurrency: ?[]const u8,

    /// The number of errors that are allowed before the system stops sending
    /// requests to run the
    /// association on additional targets. You can specify either an absolute number
    /// of errors, for
    /// example 10, or a percentage of the target set, for example 10%. If you
    /// specify 3, for example,
    /// the system stops sending requests when the fourth error is received. If you
    /// specify 0, then the
    /// system stops sending requests after the first error is returned. If you run
    /// an association on 50
    /// managed nodes and set `MaxError` to 10%, then the system stops sending the
    /// request
    /// when the sixth error is received.
    ///
    /// Executions that are already running an association when `MaxErrors` is
    /// reached
    /// are allowed to complete, but some of these executions may fail as well. If
    /// you need to ensure
    /// that there won't be more than max-errors failed executions, set
    /// `MaxConcurrency` to 1
    /// so that executions proceed one at a time.
    max_errors: ?[]const u8,

    /// The name of the SSM document that contains the configuration information for
    /// the managed
    /// node. You can specify Command or Automation runbooks.
    ///
    /// You can specify Amazon Web Services-predefined documents, documents you
    /// created, or a document that is
    /// shared with you from another account.
    ///
    /// For SSM documents that are shared with you from other Amazon Web Services
    /// accounts, you must specify the
    /// complete SSM document ARN, in the following format:
    ///
    /// `arn:aws:ssm:*region*:*account-id*:document/*document-name*
    /// `
    ///
    /// For example:
    ///
    /// `arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document`
    ///
    /// For Amazon Web Services-predefined documents and SSM documents you created
    /// in your account, you only need
    /// to specify the document name. For example, `AWS-ApplyPatchBaseline` or
    /// `My-Document`.
    name: []const u8,

    /// An S3 bucket where you want to store the results of this request.
    output_location: ?InstanceAssociationOutputLocation,

    /// A description of the parameters for a document.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// A cron expression that specifies a schedule when the association runs.
    schedule_expression: ?[]const u8,

    /// Number of days to wait after the scheduled day to run an association.
    schedule_offset: ?i32,

    /// The mode for generating association compliance. You can specify `AUTO` or
    /// `MANUAL`. In `AUTO` mode, the system uses the status of the association
    /// execution to determine the compliance status. If the association execution
    /// runs successfully,
    /// then the association is `COMPLIANT`. If the association execution doesn't
    /// run
    /// successfully, the association is `NON-COMPLIANT`.
    ///
    /// In `MANUAL` mode, you must specify the `AssociationId` as a parameter
    /// for the PutComplianceItems API operation. In this case, compliance data
    /// isn't
    /// managed by State Manager, a tool in Amazon Web Services Systems Manager. It
    /// is managed by your direct call to the PutComplianceItems API operation.
    ///
    /// By default, all associations use `AUTO` mode.
    sync_compliance: ?AssociationSyncCompliance,

    /// Use this action to create an association in multiple Regions and multiple
    /// accounts.
    target_locations: ?[]const TargetLocation,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The managed nodes targeted by the request.
    targets: ?[]const Target,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .apply_only_at_cron_interval = "ApplyOnlyAtCronInterval",
        .association_name = "AssociationName",
        .automation_target_parameter_name = "AutomationTargetParameterName",
        .calendar_names = "CalendarNames",
        .compliance_severity = "ComplianceSeverity",
        .document_version = "DocumentVersion",
        .duration = "Duration",
        .instance_id = "InstanceId",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .output_location = "OutputLocation",
        .parameters = "Parameters",
        .schedule_expression = "ScheduleExpression",
        .schedule_offset = "ScheduleOffset",
        .sync_compliance = "SyncCompliance",
        .target_locations = "TargetLocations",
        .target_maps = "TargetMaps",
        .targets = "Targets",
    };
};
