const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AssociationComplianceSeverity = @import("association_compliance_severity.zig").AssociationComplianceSeverity;
const InstanceAssociationOutputLocation = @import("instance_association_output_location.zig").InstanceAssociationOutputLocation;
const AssociationOverview = @import("association_overview.zig").AssociationOverview;
const AssociationStatus = @import("association_status.zig").AssociationStatus;
const AssociationSyncCompliance = @import("association_sync_compliance.zig").AssociationSyncCompliance;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Describes the parameters for a document.
pub const AssociationDescription = struct {
    alarm_configuration: ?AlarmConfiguration,

    /// By default, when you create a new associations, the system runs it
    /// immediately after it is
    /// created and then according to the schedule you specified. Specify this
    /// option if you don't want
    /// an association to run immediately after you create it. This parameter isn't
    /// supported for rate
    /// expressions.
    apply_only_at_cron_interval: bool = false,

    /// The association ID.
    association_id: ?[]const u8,

    /// The association name.
    association_name: ?[]const u8,

    /// The association version.
    association_version: ?[]const u8,

    /// Choose the parameter that will define how your automation will branch out.
    /// This target is
    /// required for associations that use an Automation runbook and target
    /// resources by using rate
    /// controls. Automation is a tool in Amazon Web Services Systems Manager.
    automation_target_parameter_name: ?[]const u8,

    /// The names or Amazon Resource Names (ARNs) of the Change Calendar type
    /// documents your
    /// associations are gated under. The associations only run when that change
    /// calendar is open. For
    /// more information, see [Amazon Web Services Systems Manager Change
    /// Calendar](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar) in the *Amazon Web Services Systems Manager User Guide*.
    calendar_names: ?[]const []const u8,

    /// The severity level that is assigned to the association.
    compliance_severity: ?AssociationComplianceSeverity,

    /// The date when the association was made.
    date: ?i64,

    /// The document version.
    document_version: ?[]const u8,

    /// The number of hours that an association can run on specified targets. After
    /// the resulting
    /// cutoff time passes, associations that are currently running are cancelled,
    /// and no pending
    /// executions are started on remaining targets.
    duration: ?i32,

    /// The managed node ID.
    instance_id: ?[]const u8,

    /// The date on which the association was last run.
    last_execution_date: ?i64,

    /// The last date on which the association was successfully run.
    last_successful_execution_date: ?i64,

    /// The date when the association was last updated.
    last_update_association_date: ?i64,

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

    /// The name of the SSM document.
    name: ?[]const u8,

    /// An S3 bucket where you want to store the output details of the request.
    output_location: ?InstanceAssociationOutputLocation,

    /// Information about the association.
    overview: ?AssociationOverview,

    /// A description of the parameters for a document.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// A cron expression that specifies a schedule when the association runs.
    schedule_expression: ?[]const u8,

    /// Number of days to wait after the scheduled day to run an association.
    schedule_offset: ?i32,

    /// The association status.
    status: ?AssociationStatus,

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

    /// The combination of Amazon Web Services Regions and Amazon Web Services
    /// accounts where you want to run the
    /// association.
    target_locations: ?[]const TargetLocation,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The managed nodes targeted by the request.
    targets: ?[]const Target,

    /// The CloudWatch alarm that was invoked during the association.
    triggered_alarms: ?[]const AlarmStateInformation,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .apply_only_at_cron_interval = "ApplyOnlyAtCronInterval",
        .association_id = "AssociationId",
        .association_name = "AssociationName",
        .association_version = "AssociationVersion",
        .automation_target_parameter_name = "AutomationTargetParameterName",
        .calendar_names = "CalendarNames",
        .compliance_severity = "ComplianceSeverity",
        .date = "Date",
        .document_version = "DocumentVersion",
        .duration = "Duration",
        .instance_id = "InstanceId",
        .last_execution_date = "LastExecutionDate",
        .last_successful_execution_date = "LastSuccessfulExecutionDate",
        .last_update_association_date = "LastUpdateAssociationDate",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .output_location = "OutputLocation",
        .overview = "Overview",
        .parameters = "Parameters",
        .schedule_expression = "ScheduleExpression",
        .schedule_offset = "ScheduleOffset",
        .status = "Status",
        .sync_compliance = "SyncCompliance",
        .target_locations = "TargetLocations",
        .target_maps = "TargetMaps",
        .targets = "Targets",
        .triggered_alarms = "TriggeredAlarms",
    };
};
