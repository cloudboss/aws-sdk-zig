const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, options: CallOptions) !UpdateMaintenanceWindowTaskOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, config: *aws.Config) !aws.http.Request {
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        const parsed_error: ?errors.AssociatedInstances = aws.json.parseJsonObject(errors.AssociatedInstances, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .associated_instances = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        const parsed_error: ?errors.AssociationAlreadyExists = aws.json.parseJsonObject(errors.AssociationAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        const parsed_error: ?errors.AssociationDoesNotExist = aws.json.parseJsonObject(errors.AssociationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        const parsed_error: ?errors.AssociationExecutionDoesNotExist = aws.json.parseJsonObject(errors.AssociationExecutionDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_execution_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        const parsed_error: ?errors.AssociationLimitExceeded = aws.json.parseJsonObject(errors.AssociationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        const parsed_error: ?errors.AssociationVersionLimitExceeded = aws.json.parseJsonObject(errors.AssociationVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        const parsed_error: ?errors.AutomationDefinitionNotApprovedException = aws.json.parseJsonObject(errors.AutomationDefinitionNotApprovedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_approved_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionVersionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionVersionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_version_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        const parsed_error: ?errors.AutomationExecutionLimitExceededException = aws.json.parseJsonObject(errors.AutomationExecutionLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        const parsed_error: ?errors.AutomationExecutionNotFoundException = aws.json.parseJsonObject(errors.AutomationExecutionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        const parsed_error: ?errors.AutomationStepNotFoundException = aws.json.parseJsonObject(errors.AutomationStepNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_step_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        const parsed_error: ?errors.ComplianceTypeCountLimitExceededException = aws.json.parseJsonObject(errors.ComplianceTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .compliance_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        const parsed_error: ?errors.CustomSchemaCountLimitExceededException = aws.json.parseJsonObject(errors.CustomSchemaCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_schema_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        const parsed_error: ?errors.DocumentAlreadyExists = aws.json.parseJsonObject(errors.DocumentAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        const parsed_error: ?errors.DocumentLimitExceeded = aws.json.parseJsonObject(errors.DocumentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        const parsed_error: ?errors.DocumentPermissionLimit = aws.json.parseJsonObject(errors.DocumentPermissionLimit, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_permission_limit = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        const parsed_error: ?errors.DocumentVersionLimitExceeded = aws.json.parseJsonObject(errors.DocumentVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        const parsed_error: ?errors.DoesNotExistException = aws.json.parseJsonObject(errors.DoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        const parsed_error: ?errors.DuplicateDocumentContent = aws.json.parseJsonObject(errors.DuplicateDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        const parsed_error: ?errors.DuplicateDocumentVersionName = aws.json.parseJsonObject(errors.DuplicateDocumentVersionName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_version_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        const parsed_error: ?errors.DuplicateInstanceId = aws.json.parseJsonObject(errors.DuplicateInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        const parsed_error: ?errors.FeatureNotAvailableException = aws.json.parseJsonObject(errors.FeatureNotAvailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .feature_not_available_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        const parsed_error: ?errors.HierarchyLevelLimitExceededException = aws.json.parseJsonObject(errors.HierarchyLevelLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_level_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        const parsed_error: ?errors.HierarchyTypeMismatchException = aws.json.parseJsonObject(errors.HierarchyTypeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_type_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        const parsed_error: ?errors.IdempotentParameterMismatch = aws.json.parseJsonObject(errors.IdempotentParameterMismatch, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        const parsed_error: ?errors.IncompatiblePolicyException = aws.json.parseJsonObject(errors.IncompatiblePolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        const parsed_error: ?errors.InvalidActivation = aws.json.parseJsonObject(errors.InvalidActivation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        const parsed_error: ?errors.InvalidActivationId = aws.json.parseJsonObject(errors.InvalidActivationId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        const parsed_error: ?errors.InvalidAggregatorException = aws.json.parseJsonObject(errors.InvalidAggregatorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_aggregator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        const parsed_error: ?errors.InvalidAllowedPatternException = aws.json.parseJsonObject(errors.InvalidAllowedPatternException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_allowed_pattern_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        const parsed_error: ?errors.InvalidAssociation = aws.json.parseJsonObject(errors.InvalidAssociation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        const parsed_error: ?errors.InvalidAssociationVersion = aws.json.parseJsonObject(errors.InvalidAssociationVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        const parsed_error: ?errors.InvalidAutomationExecutionParametersException = aws.json.parseJsonObject(errors.InvalidAutomationExecutionParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_execution_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        const parsed_error: ?errors.InvalidAutomationSignalException = aws.json.parseJsonObject(errors.InvalidAutomationSignalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_signal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        const parsed_error: ?errors.InvalidAutomationStatusUpdateException = aws.json.parseJsonObject(errors.InvalidAutomationStatusUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_status_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        const parsed_error: ?errors.InvalidCommandId = aws.json.parseJsonObject(errors.InvalidCommandId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_command_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        const parsed_error: ?errors.InvalidDeleteInventoryParametersException = aws.json.parseJsonObject(errors.InvalidDeleteInventoryParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_delete_inventory_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        const parsed_error: ?errors.InvalidDeletionIdException = aws.json.parseJsonObject(errors.InvalidDeletionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deletion_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        const parsed_error: ?errors.InvalidDocument = aws.json.parseJsonObject(errors.InvalidDocument, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        const parsed_error: ?errors.InvalidDocumentContent = aws.json.parseJsonObject(errors.InvalidDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        const parsed_error: ?errors.InvalidDocumentOperation = aws.json.parseJsonObject(errors.InvalidDocumentOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_operation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        const parsed_error: ?errors.InvalidDocumentSchemaVersion = aws.json.parseJsonObject(errors.InvalidDocumentSchemaVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_schema_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        const parsed_error: ?errors.InvalidDocumentType = aws.json.parseJsonObject(errors.InvalidDocumentType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        const parsed_error: ?errors.InvalidDocumentVersion = aws.json.parseJsonObject(errors.InvalidDocumentVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        const parsed_error: ?errors.InvalidFilter = aws.json.parseJsonObject(errors.InvalidFilter, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        const parsed_error: ?errors.InvalidFilterKey = aws.json.parseJsonObject(errors.InvalidFilterKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        const parsed_error: ?errors.InvalidFilterOption = aws.json.parseJsonObject(errors.InvalidFilterOption, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_option = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        const parsed_error: ?errors.InvalidFilterValue = aws.json.parseJsonObject(errors.InvalidFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        const parsed_error: ?errors.InvalidInstanceId = aws.json.parseJsonObject(errors.InvalidInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        const parsed_error: ?errors.InvalidInstanceInformationFilterValue = aws.json.parseJsonObject(errors.InvalidInstanceInformationFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_information_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        const parsed_error: ?errors.InvalidInstancePropertyFilterValue = aws.json.parseJsonObject(errors.InvalidInstancePropertyFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_property_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        const parsed_error: ?errors.InvalidInventoryGroupException = aws.json.parseJsonObject(errors.InvalidInventoryGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        const parsed_error: ?errors.InvalidInventoryItemContextException = aws.json.parseJsonObject(errors.InvalidInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        const parsed_error: ?errors.InvalidInventoryRequestException = aws.json.parseJsonObject(errors.InvalidInventoryRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        const parsed_error: ?errors.InvalidItemContentException = aws.json.parseJsonObject(errors.InvalidItemContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_item_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        const parsed_error: ?errors.InvalidKeyId = aws.json.parseJsonObject(errors.InvalidKeyId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        const parsed_error: ?errors.InvalidNextToken = aws.json.parseJsonObject(errors.InvalidNextToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        const parsed_error: ?errors.InvalidNotificationConfig = aws.json.parseJsonObject(errors.InvalidNotificationConfig, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_notification_config = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        const parsed_error: ?errors.InvalidOptionException = aws.json.parseJsonObject(errors.InvalidOptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_option_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        const parsed_error: ?errors.InvalidOutputFolder = aws.json.parseJsonObject(errors.InvalidOutputFolder, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_folder = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        const parsed_error: ?errors.InvalidOutputLocation = aws.json.parseJsonObject(errors.InvalidOutputLocation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_location = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        const parsed_error: ?errors.InvalidParameters = aws.json.parseJsonObject(errors.InvalidParameters, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameters = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        const parsed_error: ?errors.InvalidPermissionType = aws.json.parseJsonObject(errors.InvalidPermissionType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_permission_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        const parsed_error: ?errors.InvalidPluginName = aws.json.parseJsonObject(errors.InvalidPluginName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_plugin_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        const parsed_error: ?errors.InvalidPolicyAttributeException = aws.json.parseJsonObject(errors.InvalidPolicyAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        const parsed_error: ?errors.InvalidPolicyTypeException = aws.json.parseJsonObject(errors.InvalidPolicyTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        const parsed_error: ?errors.InvalidResourceId = aws.json.parseJsonObject(errors.InvalidResourceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        const parsed_error: ?errors.InvalidResourceType = aws.json.parseJsonObject(errors.InvalidResourceType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        const parsed_error: ?errors.InvalidResultAttributeException = aws.json.parseJsonObject(errors.InvalidResultAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_result_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        const parsed_error: ?errors.InvalidRole = aws.json.parseJsonObject(errors.InvalidRole, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        const parsed_error: ?errors.InvalidSchedule = aws.json.parseJsonObject(errors.InvalidSchedule, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_schedule = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        const parsed_error: ?errors.InvalidTag = aws.json.parseJsonObject(errors.InvalidTag, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        const parsed_error: ?errors.InvalidTarget = aws.json.parseJsonObject(errors.InvalidTarget, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        const parsed_error: ?errors.InvalidTargetMaps = aws.json.parseJsonObject(errors.InvalidTargetMaps, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_maps = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        const parsed_error: ?errors.InvalidTypeNameException = aws.json.parseJsonObject(errors.InvalidTypeNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_type_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        const parsed_error: ?errors.InvalidUpdate = aws.json.parseJsonObject(errors.InvalidUpdate, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_update = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        const parsed_error: ?errors.InvocationDoesNotExist = aws.json.parseJsonObject(errors.InvocationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invocation_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        const parsed_error: ?errors.ItemContentMismatchException = aws.json.parseJsonObject(errors.ItemContentMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_content_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        const parsed_error: ?errors.ItemSizeLimitExceededException = aws.json.parseJsonObject(errors.ItemSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        const parsed_error: ?errors.MalformedResourcePolicyDocumentException = aws.json.parseJsonObject(errors.MalformedResourcePolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_resource_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        const parsed_error: ?errors.MaxDocumentSizeExceeded = aws.json.parseJsonObject(errors.MaxDocumentSizeExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_document_size_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        const parsed_error: ?errors.NoLongerSupportedException = aws.json.parseJsonObject(errors.NoLongerSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_longer_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        const parsed_error: ?errors.OpsItemAccessDeniedException = aws.json.parseJsonObject(errors.OpsItemAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        const parsed_error: ?errors.OpsItemConflictException = aws.json.parseJsonObject(errors.OpsItemConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        const parsed_error: ?errors.OpsItemInvalidParameterException = aws.json.parseJsonObject(errors.OpsItemInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        const parsed_error: ?errors.OpsItemLimitExceededException = aws.json.parseJsonObject(errors.OpsItemLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        const parsed_error: ?errors.OpsItemNotFoundException = aws.json.parseJsonObject(errors.OpsItemNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAssociationNotFoundException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAssociationNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_association_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        const parsed_error: ?errors.OpsMetadataAlreadyExistsException = aws.json.parseJsonObject(errors.OpsMetadataAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        const parsed_error: ?errors.OpsMetadataInvalidArgumentException = aws.json.parseJsonObject(errors.OpsMetadataInvalidArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_invalid_argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataKeyLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataKeyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_key_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        const parsed_error: ?errors.OpsMetadataNotFoundException = aws.json.parseJsonObject(errors.OpsMetadataNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        const parsed_error: ?errors.OpsMetadataTooManyUpdatesException = aws.json.parseJsonObject(errors.OpsMetadataTooManyUpdatesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_too_many_updates_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        const parsed_error: ?errors.ParameterAlreadyExists = aws.json.parseJsonObject(errors.ParameterAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        const parsed_error: ?errors.ParameterLimitExceeded = aws.json.parseJsonObject(errors.ParameterLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        const parsed_error: ?errors.ParameterMaxVersionLimitExceeded = aws.json.parseJsonObject(errors.ParameterMaxVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_max_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        const parsed_error: ?errors.ParameterNotFound = aws.json.parseJsonObject(errors.ParameterNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        const parsed_error: ?errors.ParameterPatternMismatchException = aws.json.parseJsonObject(errors.ParameterPatternMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_pattern_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        const parsed_error: ?errors.ParameterVersionLabelLimitExceeded = aws.json.parseJsonObject(errors.ParameterVersionLabelLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_label_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        const parsed_error: ?errors.ParameterVersionNotFound = aws.json.parseJsonObject(errors.ParameterVersionNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        const parsed_error: ?errors.PoliciesLimitExceededException = aws.json.parseJsonObject(errors.PoliciesLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policies_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        const parsed_error: ?errors.ResourceDataSyncAlreadyExistsException = aws.json.parseJsonObject(errors.ResourceDataSyncAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        const parsed_error: ?errors.ResourceDataSyncConflictException = aws.json.parseJsonObject(errors.ResourceDataSyncConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        const parsed_error: ?errors.ResourceDataSyncCountExceededException = aws.json.parseJsonObject(errors.ResourceDataSyncCountExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_count_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        const parsed_error: ?errors.ResourceDataSyncInvalidConfigurationException = aws.json.parseJsonObject(errors.ResourceDataSyncInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        const parsed_error: ?errors.ResourceDataSyncNotFoundException = aws.json.parseJsonObject(errors.ResourceDataSyncNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        const parsed_error: ?errors.ResourceLimitExceededException = aws.json.parseJsonObject(errors.ResourceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        const parsed_error: ?errors.ResourcePolicyConflictException = aws.json.parseJsonObject(errors.ResourcePolicyConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        const parsed_error: ?errors.ResourcePolicyInvalidParameterException = aws.json.parseJsonObject(errors.ResourcePolicyInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        const parsed_error: ?errors.ResourcePolicyLimitExceededException = aws.json.parseJsonObject(errors.ResourcePolicyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        const parsed_error: ?errors.ResourcePolicyNotFoundException = aws.json.parseJsonObject(errors.ResourcePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        const parsed_error: ?errors.ServiceSettingNotFound = aws.json.parseJsonObject(errors.ServiceSettingNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_setting_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        const parsed_error: ?errors.StatusUnchanged = aws.json.parseJsonObject(errors.StatusUnchanged, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .status_unchanged = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        const parsed_error: ?errors.SubTypeCountLimitExceededException = aws.json.parseJsonObject(errors.SubTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sub_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        const parsed_error: ?errors.TargetInUseException = aws.json.parseJsonObject(errors.TargetInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        const parsed_error: ?errors.TargetNotConnected = aws.json.parseJsonObject(errors.TargetNotConnected, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_connected = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        const parsed_error: ?errors.TooManyTagsError = aws.json.parseJsonObject(errors.TooManyTagsError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        const parsed_error: ?errors.TooManyUpdates = aws.json.parseJsonObject(errors.TooManyUpdates, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_updates = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        const parsed_error: ?errors.TotalSizeLimitExceededException = aws.json.parseJsonObject(errors.TotalSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .total_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        const parsed_error: ?errors.UnsupportedCalendarException = aws.json.parseJsonObject(errors.UnsupportedCalendarException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_calendar_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        const parsed_error: ?errors.UnsupportedFeatureRequiredException = aws.json.parseJsonObject(errors.UnsupportedFeatureRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_feature_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        const parsed_error: ?errors.UnsupportedInventoryItemContextException = aws.json.parseJsonObject(errors.UnsupportedInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        const parsed_error: ?errors.UnsupportedInventorySchemaVersionException = aws.json.parseJsonObject(errors.UnsupportedInventorySchemaVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_schema_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        const parsed_error: ?errors.UnsupportedOperatingSystem = aws.json.parseJsonObject(errors.UnsupportedOperatingSystem, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operating_system = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        const parsed_error: ?errors.UnsupportedParameterType = aws.json.parseJsonObject(errors.UnsupportedParameterType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_parameter_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        const parsed_error: ?errors.UnsupportedPlatformType = aws.json.parseJsonObject(errors.UnsupportedPlatformType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_platform_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
