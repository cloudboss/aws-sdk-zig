const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AssociationComplianceSeverity = @import("association_compliance_severity.zig").AssociationComplianceSeverity;
const InstanceAssociationOutputLocation = @import("instance_association_output_location.zig").InstanceAssociationOutputLocation;
const AssociationSyncCompliance = @import("association_sync_compliance.zig").AssociationSyncCompliance;
const Tag = @import("tag.zig").Tag;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;
const AssociationDescription = @import("association_description.zig").AssociationDescription;

pub const CreateAssociationInput = struct {
    alarm_configuration: ?AlarmConfiguration = null,

    /// By default, when you create a new association, the system runs it
    /// immediately after it is
    /// created and then according to the schedule you specified and when target
    /// changes are detected.
    /// Specify `true` for `ApplyOnlyAtCronInterval`if you want the association to
    /// run only according to the schedule you specified.
    ///
    /// For more information, see [Understanding when associations are applied to
    /// resources](https://docs.aws.amazon.com/systems-manager/latest/userguide/state-manager-about.html#state-manager-about-scheduling) and [>About
    /// target updates with Automation
    /// runbooks](https://docs.aws.amazon.com/systems-manager/latest/userguide/state-manager-about.html#runbook-target-updates) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// This parameter isn't supported for rate expressions.
    apply_only_at_cron_interval: ?bool = null,

    /// A role used by association to take actions on your behalf.
    /// State Manager will assume this role and call required APIs when dispatching
    /// configurations to nodes. If not specified, [
    /// service-linked role for Systems
    /// Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html) will be used by default.
    ///
    /// It is recommended that you define a custom IAM role so that you have full
    /// control of
    /// the permissions that State Manager has when taking actions on your behalf.
    ///
    /// Service-linked role support in State Manager is being phased out.
    /// Associations
    /// relying on service-linked role may require updates in the future to continue
    /// functioning properly.
    association_dispatch_assume_role: ?[]const u8 = null,

    /// Specify a descriptive name for the association.
    association_name: ?[]const u8 = null,

    /// Choose the parameter that will define how your automation will branch out.
    /// This target is
    /// required for associations that use an Automation runbook and target
    /// resources by using rate
    /// controls. Automation is a tool in Amazon Web Services Systems Manager.
    automation_target_parameter_name: ?[]const u8 = null,

    /// The names of Amazon Resource Names (ARNs) of the Change Calendar type
    /// documents you want to
    /// gate your associations under. The associations only run when that change
    /// calendar is open. For
    /// more information, see [Amazon Web Services Systems Manager Change
    /// Calendar](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar) in the *Amazon Web Services Systems Manager User Guide*.
    calendar_names: ?[]const []const u8 = null,

    /// The severity level to assign to the association.
    compliance_severity: ?AssociationComplianceSeverity = null,

    /// The document version you want to associate with the targets. Can be a
    /// specific version or
    /// the default version.
    ///
    /// State Manager doesn't support running associations that use a new version of
    /// a document if
    /// that document is shared from another account. State Manager always runs the
    /// `default`
    /// version of a document if shared from another account, even though the
    /// Systems Manager console shows that a
    /// new version was processed. If you want to run an association using a new
    /// version of a document
    /// shared form another account, you must set the document version to `default`.
    document_version: ?[]const u8 = null,

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
    /// [ApplyOnlyAtCronInterval](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_CreateAssociation.html#systemsmanager-CreateAssociation-request-ApplyOnlyAtCronInterval)
    /// ` parameter, which means that the association doesn't
    /// run immediately after it is created, but only according to the specified
    /// schedule.
    duration: ?i32 = null,

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
    instance_id: ?[]const u8 = null,

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

    /// The name of the SSM Command document or Automation runbook that contains the
    /// configuration
    /// information for the managed node.
    ///
    /// You can specify Amazon Web Services-predefined documents, documents you
    /// created, or a document that is
    /// shared with you from another Amazon Web Services account.
    ///
    /// For Systems Manager documents (SSM documents) that are shared with you from
    /// other Amazon Web Services accounts, you
    /// must specify the complete SSM document ARN, in the following format:
    ///
    /// `arn:*partition*:ssm:*region*:*account-id*:document/*document-name*
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

    /// An Amazon Simple Storage Service (Amazon S3) bucket where you want to store
    /// the output
    /// details of the request.
    output_location: ?InstanceAssociationOutputLocation = null,

    /// The parameters for the runtime configuration of the document.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// A cron expression when the association will be applied to the targets.
    schedule_expression: ?[]const u8 = null,

    /// Number of days to wait after the scheduled day to run an association. For
    /// example, if you
    /// specified a cron schedule of `cron(0 0 ? * THU#2 *)`, you could specify an
    /// offset of 3
    /// to run the association each Sunday after the second Thursday of the month.
    /// For more information
    /// about cron schedules for associations, see [Reference: Cron
    /// and rate expressions for Systems
    /// Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/reference-cron-and-rate-expressions.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// To use offsets, you must specify the `ApplyOnlyAtCronInterval` parameter.
    /// This
    /// option tells the system not to run an association immediately after you
    /// create it.
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
    /// managed by State Manager. It is managed by your direct call to the
    /// PutComplianceItems API operation.
    ///
    /// By default, all associations use `AUTO` mode.
    sync_compliance: ?AssociationSyncCompliance = null,

    /// Adds or overwrites one or more tags for a State Manager association.
    /// *Tags* are metadata that you can assign to your Amazon Web Services
    /// resources. Tags enable
    /// you to categorize your resources in different ways, for example, by purpose,
    /// owner, or
    /// environment. Each tag consists of a key and an optional value, both of which
    /// you define.
    tags: ?[]const Tag = null,

    /// A location is a combination of Amazon Web Services Regions and Amazon Web
    /// Services accounts where you want to run the
    /// association. Use this action to create an association in multiple Regions
    /// and multiple
    /// accounts.
    ///
    /// The `TargetLocationAlarmConfiguration` parameter is not supported by State
    /// Manager.
    target_locations: ?[]const TargetLocation = null,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8) = null,

    /// The targets for the association. You can target managed nodes by using tags,
    /// Amazon Web Services resource
    /// groups, all managed nodes in an Amazon Web Services account, or individual
    /// managed node IDs. You can target all
    /// managed nodes in an Amazon Web Services account by specifying the
    /// `InstanceIds` key with a value of
    /// `*`. For more information about choosing targets for an association, see
    /// [Understanding targets and rate controls in State Manager
    /// associations](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-state-manager-targets-and-rate-controls.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    targets: ?[]const Target = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .apply_only_at_cron_interval = "ApplyOnlyAtCronInterval",
        .association_dispatch_assume_role = "AssociationDispatchAssumeRole",
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
        .tags = "Tags",
        .target_locations = "TargetLocations",
        .target_maps = "TargetMaps",
        .targets = "Targets",
    };
};

pub const CreateAssociationOutput = struct {
    /// Information about the association.
    association_description: ?AssociationDescription = null,

    pub const json_field_names = .{
        .association_description = "AssociationDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssociationInput, options: CallOptions) !CreateAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAssociationOutput, body, allocator);
}
