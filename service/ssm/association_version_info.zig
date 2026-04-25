const aws = @import("aws");

const AssociationComplianceSeverity = @import("association_compliance_severity.zig").AssociationComplianceSeverity;
const InstanceAssociationOutputLocation = @import("instance_association_output_location.zig").InstanceAssociationOutputLocation;
const AssociationSyncCompliance = @import("association_sync_compliance.zig").AssociationSyncCompliance;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;

/// Information about the association version.
pub const AssociationVersionInfo = struct {
    /// By default, when you create new associations, the system runs it immediately
    /// after it is
    /// created and then according to the schedule you specified. Specify this
    /// option if you don't want
    /// an association to run immediately after you create it. This parameter isn't
    /// supported for rate
    /// expressions.
    apply_only_at_cron_interval: bool = false,

    /// A role used by association to take actions on your behalf.
    /// State Manager will assume this role and call required APIs when dispatching
    /// configurations to nodes. If not specified, [
    /// service-linked role for Systems
    /// Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html) will be used by default.
    association_dispatch_assume_role: ?[]const u8 = null,

    /// The ID created by the system when the association was created.
    association_id: ?[]const u8 = null,

    /// The name specified for the association version when the association version
    /// was
    /// created.
    association_name: ?[]const u8 = null,

    /// The association version.
    association_version: ?[]const u8 = null,

    /// The names or Amazon Resource Names (ARNs) of the Change Calendar type
    /// documents your
    /// associations are gated under. The associations for this version only run
    /// when that Change
    /// Calendar is open. For more information, see [Amazon Web Services Systems
    /// Manager Change
    /// Calendar](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar) in the *Amazon Web Services Systems Manager User Guide*.
    calendar_names: ?[]const []const u8 = null,

    /// The severity level that is assigned to the association.
    compliance_severity: ?AssociationComplianceSeverity = null,

    /// The date the association version was created.
    created_date: ?i64 = null,

    /// The version of an Amazon Web Services Systems Manager document (SSM
    /// document) used when the association version was
    /// created.
    document_version: ?[]const u8 = null,

    /// The number of hours that an association can run on specified targets. After
    /// the resulting
    /// cutoff time passes, associations that are currently running are cancelled,
    /// and no pending
    /// executions are started on remaining targets.
    duration: ?i32 = null,

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
    max_concurrency: ?[]const u8 = null,

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
    max_errors: ?[]const u8 = null,

    /// The name specified when the association was created.
    name: ?[]const u8 = null,

    /// The location in Amazon S3 specified for the association when the association
    /// version
    /// was created.
    output_location: ?InstanceAssociationOutputLocation = null,

    /// Parameters specified when the association version was created.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The cron or rate schedule specified for the association when the association
    /// version was
    /// created.
    schedule_expression: ?[]const u8 = null,

    /// Number of days to wait after the scheduled day to run an association.
    schedule_offset: ?i32 = null,

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
    sync_compliance: ?AssociationSyncCompliance = null,

    /// The combination of Amazon Web Services Regions and Amazon Web Services
    /// accounts where you wanted to run the association
    /// when this association version was created.
    target_locations: ?[]const TargetLocation = null,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8) = null,

    /// The targets specified for the association when the association version was
    /// created.
    targets: ?[]const Target = null,

    pub const json_field_names = .{
        .apply_only_at_cron_interval = "ApplyOnlyAtCronInterval",
        .association_dispatch_assume_role = "AssociationDispatchAssumeRole",
        .association_id = "AssociationId",
        .association_name = "AssociationName",
        .association_version = "AssociationVersion",
        .calendar_names = "CalendarNames",
        .compliance_severity = "ComplianceSeverity",
        .created_date = "CreatedDate",
        .document_version = "DocumentVersion",
        .duration = "Duration",
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
