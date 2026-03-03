const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const MaintenanceWindowTaskCutoffBehavior = @import("maintenance_window_task_cutoff_behavior.zig").MaintenanceWindowTaskCutoffBehavior;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const Target = @import("target.zig").Target;
const MaintenanceWindowTaskInvocationParameters = @import("maintenance_window_task_invocation_parameters.zig").MaintenanceWindowTaskInvocationParameters;
const MaintenanceWindowTaskParameterValueExpression = @import("maintenance_window_task_parameter_value_expression.zig").MaintenanceWindowTaskParameterValueExpression;

pub const UpdateMaintenanceWindowTaskInput = struct {
    /// The CloudWatch alarm you want to apply to your maintenance window task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// Indicates whether tasks should continue to run after the cutoff time
    /// specified in the
    /// maintenance windows is reached.
    ///
    /// * `CONTINUE_TASK`: When the cutoff time is reached, any tasks that are
    ///   running
    /// continue. The default value.
    ///
    /// * `CANCEL_TASK`:
    ///
    /// * For Automation, Lambda, Step Functions tasks: When the cutoff
    /// time is reached, any task invocations that are already running continue, but
    /// no new task
    /// invocations are started.
    ///
    /// * For Run Command tasks: When the cutoff time is reached, the system sends a
    ///   CancelCommand operation that attempts to cancel the command associated
    ///   with the
    /// task. However, there is no guarantee that the command will be terminated and
    /// the underlying
    /// process stopped.
    ///
    /// The status for tasks that are not completed is `TIMED_OUT`.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior = null,

    /// The new task description to specify.
    description: ?[]const u8 = null,

    /// The new logging location in Amazon S3 to specify.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo = null,

    /// The new `MaxConcurrency` value you want to specify. `MaxConcurrency`
    /// is the number of targets that are allowed to run this task, in parallel.
    ///
    /// Although this element is listed as "Required: No", a value can be omitted
    /// only when you are
    /// registering or updating a [targetless
    /// task](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) You must provide a value in all other cases.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`. This value
    /// doesn't
    /// affect the running of your task.
    max_concurrency: ?[]const u8 = null,

    /// The new `MaxErrors` value to specify. `MaxErrors` is the maximum
    /// number of errors that are allowed before the task stops being scheduled.
    ///
    /// Although this element is listed as "Required: No", a value can be omitted
    /// only when you are
    /// registering or updating a [targetless
    /// task](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) You must provide a value in all other cases.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`. This value
    /// doesn't
    /// affect the running of your task.
    max_errors: ?[]const u8 = null,

    /// The new task name to specify.
    name: ?[]const u8 = null,

    /// The new task priority to specify. The lower the number, the higher the
    /// priority. Tasks that
    /// have the same priority are scheduled in parallel.
    priority: ?i32 = null,

    /// If True, then all fields that are required by the
    /// RegisterTaskWithMaintenanceWindow operation are also required for this API
    /// request.
    /// Optional fields that aren't specified are set to null.
    replace: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM service role for
    /// Amazon Web Services Systems Manager to assume when running a maintenance
    /// window task. If you do not specify a
    /// service role ARN, Systems Manager uses a service-linked role in your
    /// account. If no
    /// appropriate service-linked role for Systems Manager exists in your account,
    /// it is created when
    /// you run `RegisterTaskWithMaintenanceWindow`.
    ///
    /// However, for an improved security posture, we strongly recommend creating a
    /// custom
    /// policy and custom service role for running your maintenance window tasks.
    /// The policy
    /// can be crafted to provide only the permissions needed for your particular
    /// maintenance window tasks. For more information, see [Setting up Maintenance
    /// Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html) in the in the
    /// *Amazon Web Services Systems Manager User Guide*.
    service_role_arn: ?[]const u8 = null,

    /// The targets (either managed nodes or tags) to modify. Managed nodes are
    /// specified using the
    /// format `Key=instanceids,Values=instanceID_1,instanceID_2`. Tags are
    /// specified using
    /// the format ` Key=tag_name,Values=tag_value`.
    ///
    /// One or more targets must be specified for maintenance window Run
    /// Command-type tasks.
    /// Depending on the task, targets are optional for other maintenance window
    /// task types (Automation,
    /// Lambda, and Step Functions). For more information about running tasks
    /// that don't specify targets, see [Registering
    /// maintenance window tasks without
    /// targets](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    targets: ?[]const Target = null,

    /// The task ARN to modify.
    task_arn: ?[]const u8 = null,

    /// The parameters that the task should use during execution. Populate only the
    /// fields that
    /// match the task type. All other fields should be empty.
    ///
    /// When you update a maintenance window task that has options specified in
    /// `TaskInvocationParameters`, you must provide again all the
    /// `TaskInvocationParameters` values that you want to retain. The values you
    /// don't
    /// specify again are removed. For example, suppose that when you registered a
    /// Run Command task, you
    /// specified `TaskInvocationParameters` values for `Comment`,
    /// `NotificationConfig`, and `OutputS3BucketName`. If you update the
    /// maintenance window task and specify only a different `OutputS3BucketName`
    /// value, the
    /// values for `Comment` and `NotificationConfig` are removed.
    task_invocation_parameters: ?MaintenanceWindowTaskInvocationParameters = null,

    /// The parameters to modify.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    ///
    /// The map has the following format:
    ///
    /// Key: string, between 1 and 255 characters
    ///
    /// Value: an array of strings, each string is between 1 and 255 characters
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The maintenance window ID that contains the task to modify.
    window_id: []const u8,

    /// The task ID to modify.
    window_task_id: []const u8,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cutoff_behavior = "CutoffBehavior",
        .description = "Description",
        .logging_info = "LoggingInfo",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .priority = "Priority",
        .replace = "Replace",
        .service_role_arn = "ServiceRoleArn",
        .targets = "Targets",
        .task_arn = "TaskArn",
        .task_invocation_parameters = "TaskInvocationParameters",
        .task_parameters = "TaskParameters",
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub const UpdateMaintenanceWindowTaskOutput = struct {
    /// The details for the CloudWatch alarm you applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The specification for whether tasks should continue to run after the cutoff
    /// time specified
    /// in the maintenance windows is reached.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior = null,

    /// The updated task description.
    description: ?[]const u8 = null,

    /// The updated logging information in Amazon S3.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo = null,

    /// The updated `MaxConcurrency` value.
    max_concurrency: ?[]const u8 = null,

    /// The updated `MaxErrors` value.
    max_errors: ?[]const u8 = null,

    /// The updated task name.
    name: ?[]const u8 = null,

    /// The updated priority value.
    priority: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM service role for
    /// Amazon Web Services Systems Manager to assume when running a maintenance
    /// window task. If you do not specify a
    /// service role ARN, Systems Manager uses a service-linked role in your
    /// account. If no
    /// appropriate service-linked role for Systems Manager exists in your account,
    /// it is created when
    /// you run `RegisterTaskWithMaintenanceWindow`.
    ///
    /// However, for an improved security posture, we strongly recommend creating a
    /// custom
    /// policy and custom service role for running your maintenance window tasks.
    /// The policy
    /// can be crafted to provide only the permissions needed for your particular
    /// maintenance window tasks. For more information, see [Setting up Maintenance
    /// Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html) in the in the
    /// *Amazon Web Services Systems Manager User Guide*.
    service_role_arn: ?[]const u8 = null,

    /// The updated target values.
    targets: ?[]const Target = null,

    /// The updated task ARN value.
    task_arn: ?[]const u8 = null,

    /// The updated parameter values.
    task_invocation_parameters: ?MaintenanceWindowTaskInvocationParameters = null,

    /// The updated parameter values.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The ID of the maintenance window that was updated.
    window_id: ?[]const u8 = null,

    /// The task ID of the maintenance window that was updated.
    window_task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cutoff_behavior = "CutoffBehavior",
        .description = "Description",
        .logging_info = "LoggingInfo",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .priority = "Priority",
        .service_role_arn = "ServiceRoleArn",
        .targets = "Targets",
        .task_arn = "TaskArn",
        .task_invocation_parameters = "TaskInvocationParameters",
        .task_parameters = "TaskParameters",
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, options: Options) !UpdateMaintenanceWindowTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssm");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateMaintenanceWindowTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMaintenanceWindowTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMaintenanceWindowTaskOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        return .{ .arena = arena, .kind = .{ .associated_instances = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .association_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .association_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .association_execution_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .association_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .association_version_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        return .{ .arena = arena, .kind = .{ .automation_definition_not_approved_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .automation_definition_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .automation_definition_version_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .automation_execution_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .automation_execution_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .automation_step_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .compliance_type_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .custom_schema_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .document_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .document_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        return .{ .arena = arena, .kind = .{ .document_permission_limit = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .document_version_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        return .{ .arena = arena, .kind = .{ .duplicate_document_content = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        return .{ .arena = arena, .kind = .{ .duplicate_document_version_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        return .{ .arena = arena, .kind = .{ .duplicate_instance_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .feature_not_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .hierarchy_level_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .hierarchy_type_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        return .{ .arena = arena, .kind = .{ .invalid_activation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        return .{ .arena = arena, .kind = .{ .invalid_activation_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        return .{ .arena = arena, .kind = .{ .invalid_aggregator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_allowed_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        return .{ .arena = arena, .kind = .{ .invalid_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        return .{ .arena = arena, .kind = .{ .invalid_association_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_automation_execution_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        return .{ .arena = arena, .kind = .{ .invalid_automation_signal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_automation_status_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        return .{ .arena = arena, .kind = .{ .invalid_command_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_delete_inventory_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_deletion_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_document = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        return .{ .arena = arena, .kind = .{ .invalid_document_content = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        return .{ .arena = arena, .kind = .{ .invalid_document_operation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        return .{ .arena = arena, .kind = .{ .invalid_document_schema_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        return .{ .arena = arena, .kind = .{ .invalid_document_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        return .{ .arena = arena, .kind = .{ .invalid_document_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter_option = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter_value = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        return .{ .arena = arena, .kind = .{ .invalid_instance_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        return .{ .arena = arena, .kind = .{ .invalid_instance_information_filter_value = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        return .{ .arena = arena, .kind = .{ .invalid_instance_property_filter_value = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_inventory_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        return .{ .arena = arena, .kind = .{ .invalid_inventory_item_context_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_inventory_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_item_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        return .{ .arena = arena, .kind = .{ .invalid_notification_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_option_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        return .{ .arena = arena, .kind = .{ .invalid_output_folder = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        return .{ .arena = arena, .kind = .{ .invalid_output_location = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameters = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        return .{ .arena = arena, .kind = .{ .invalid_permission_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        return .{ .arena = arena, .kind = .{ .invalid_plugin_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_attribute_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_result_attribute_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        return .{ .arena = arena, .kind = .{ .invalid_role = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        return .{ .arena = arena, .kind = .{ .invalid_schedule = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        return .{ .arena = arena, .kind = .{ .invalid_target = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_maps = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        return .{ .arena = arena, .kind = .{ .invalid_update = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .invocation_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        return .{ .arena = arena, .kind = .{ .item_content_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .item_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_resource_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        return .{ .arena = arena, .kind = .{ .max_document_size_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        return .{ .arena = arena, .kind = .{ .no_longer_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_related_item_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ops_item_related_item_association_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_key_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        return .{ .arena = arena, .kind = .{ .ops_metadata_too_many_updates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .parameter_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .parameter_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .parameter_max_version_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        return .{ .arena = arena, .kind = .{ .parameter_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        return .{ .arena = arena, .kind = .{ .parameter_pattern_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .parameter_version_label_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        return .{ .arena = arena, .kind = .{ .parameter_version_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policies_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_data_sync_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_data_sync_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_data_sync_count_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .resource_data_sync_invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_data_sync_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        return .{ .arena = arena, .kind = .{ .service_setting_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        return .{ .arena = arena, .kind = .{ .status_unchanged = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .sub_type_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        return .{ .arena = arena, .kind = .{ .target_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        return .{ .arena = arena, .kind = .{ .target_not_connected = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        return .{ .arena = arena, .kind = .{ .too_many_updates = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .total_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_calendar_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_feature_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_inventory_item_context_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_inventory_schema_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operating_system = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        return .{ .arena = arena, .kind = .{ .unsupported_parameter_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        return .{ .arena = arena, .kind = .{ .unsupported_platform_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
