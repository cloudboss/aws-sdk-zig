const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const CommandInvocationStatus = @import("command_invocation_status.zig").CommandInvocationStatus;

pub const GetCommandInvocationInput = struct {
    /// (Required) The parent command ID of the invocation plugin.
    command_id: []const u8,

    /// (Required) The ID of the managed node targeted by the command. A *managed
    /// node* can be an Amazon Elastic Compute Cloud (Amazon EC2) instance, edge
    /// device, and on-premises server or VM
    /// in your hybrid environment that is configured for Amazon Web Services
    /// Systems Manager.
    instance_id: []const u8,

    /// The name of the step for which you want detailed results. If the document
    /// contains only one
    /// step, you can omit the name and details for that step. If the document
    /// contains more than one
    /// step, you must specify the name of the step for which you want to view
    /// details. Be sure to
    /// specify the name of the step, not the name of a plugin like
    /// `aws:RunShellScript`.
    ///
    /// To find the `PluginName`, check the document content and find the name of
    /// the
    /// step you want details for. Alternatively, use ListCommandInvocations with
    /// the
    /// `CommandId` and `Details` parameters. The `PluginName` is the
    /// `Name` attribute of the `CommandPlugin` object in the
    /// `CommandPlugins` list.
    plugin_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_id = "CommandId",
        .instance_id = "InstanceId",
        .plugin_name = "PluginName",
    };
};

pub const GetCommandInvocationOutput = struct {
    /// Amazon CloudWatch Logs information where Systems Manager sent the command
    /// output.
    cloud_watch_output_config: ?CloudWatchOutputConfig = null,

    /// The parent command ID of the invocation plugin.
    command_id: ?[]const u8 = null,

    /// The comment text for the command.
    comment: ?[]const u8 = null,

    /// The name of the document that was run. For example, `AWS-RunShellScript`.
    document_name: ?[]const u8 = null,

    /// The Systems Manager document (SSM document) version used in the request.
    document_version: ?[]const u8 = null,

    /// Duration since `ExecutionStartDateTime`.
    execution_elapsed_time: ?[]const u8 = null,

    /// The date and time the plugin finished running. Date and time are written in
    /// ISO 8601 format.
    /// For example, June 7, 2017 is represented as 2017-06-7. The following sample
    /// Amazon Web Services CLI command uses
    /// the `InvokedAfter` filter.
    ///
    /// `aws ssm list-commands --filters
    /// key=InvokedAfter,value=2017-06-07T00:00:00Z`
    ///
    /// If the plugin hasn't started to run, the string is empty.
    execution_end_date_time: ?[]const u8 = null,

    /// The date and time the plugin started running. Date and time are written in
    /// ISO 8601 format.
    /// For example, June 7, 2017 is represented as 2017-06-7. The following sample
    /// Amazon Web Services CLI command uses
    /// the `InvokedBefore` filter.
    ///
    /// `aws ssm list-commands --filters
    /// key=InvokedBefore,value=2017-06-07T00:00:00Z`
    ///
    /// If the plugin hasn't started to run, the string is empty.
    execution_start_date_time: ?[]const u8 = null,

    /// The ID of the managed node targeted by the command. A *managed node* can
    /// be an Amazon Elastic Compute Cloud (Amazon EC2) instance, edge device, or
    /// on-premises server or VM in your hybrid
    /// environment that is configured for Amazon Web Services Systems Manager.
    instance_id: ?[]const u8 = null,

    /// The name of the plugin, or *step name*, for which details are reported.
    /// For example, `aws:RunShellScript` is a plugin.
    plugin_name: ?[]const u8 = null,

    /// The error level response code for the plugin script. If the response code is
    /// `-1`, then the command hasn't started running on the managed node, or it
    /// wasn't
    /// received by the node.
    response_code: ?i32 = null,

    /// The first 8,000 characters written by the plugin to `stderr`. If the command
    /// hasn't finished running, then this string is empty.
    standard_error_content: ?[]const u8 = null,

    /// The URL for the complete text written by the plugin to `stderr`. If the
    /// command
    /// hasn't finished running, then this string is empty.
    standard_error_url: ?[]const u8 = null,

    /// The first 24,000 characters written by the plugin to `stdout`. If the
    /// command
    /// hasn't finished running, if `ExecutionStatus` is neither Succeeded nor
    /// Failed, then
    /// this string is empty.
    standard_output_content: ?[]const u8 = null,

    /// The URL for the complete text written by the plugin to `stdout` in Amazon
    /// Simple Storage Service (Amazon S3). If an S3 bucket wasn't specified, then
    /// this string is
    /// empty.
    standard_output_url: ?[]const u8 = null,

    /// The status of this invocation plugin. This status can be different than
    /// `StatusDetails`.
    status: ?CommandInvocationStatus = null,

    /// A detailed status of the command execution for an invocation.
    /// `StatusDetails`
    /// includes more information than `Status` because it includes states resulting
    /// from
    /// error and concurrency control parameters. `StatusDetails` can show different
    /// results
    /// than `Status`. For more information about these statuses, see [Understanding
    /// command
    /// statuses](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html) in the *Amazon Web Services Systems Manager User Guide*.
    /// `StatusDetails` can be one of the following values:
    ///
    /// * Pending: The command hasn't been sent to the managed node.
    ///
    /// * In Progress: The command has been sent to the managed node but hasn't
    ///   reached a terminal
    /// state.
    ///
    /// * Delayed: The system attempted to send the command to the target, but the
    ///   target wasn't
    /// available. The managed node might not be available because of network
    /// issues, because the node
    /// was stopped, or for similar reasons. The system will try to send the command
    /// again.
    ///
    /// * Success: The command or plugin ran successfully. This is a terminal state.
    ///
    /// * Delivery Timed Out: The command wasn't delivered to the managed node
    ///   before the delivery
    /// timeout expired. Delivery timeouts don't count against the parent command's
    /// `MaxErrors` limit, but they do contribute to whether the parent command
    /// status is
    /// Success or Incomplete. This is a terminal state.
    ///
    /// * Execution Timed Out: The command started to run on the managed node, but
    ///   the execution
    /// wasn't complete before the timeout expired. Execution timeouts count against
    /// the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Failed: The command wasn't run successfully on the managed node. For a
    ///   plugin, this
    /// indicates that the result code wasn't zero. For a command invocation, this
    /// indicates that the
    /// result code for one or more plugins wasn't zero. Invocation failures count
    /// against the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Cancelled: The command was terminated before it was completed. This is a
    ///   terminal
    /// state.
    ///
    /// * Undeliverable: The command can't be delivered to the managed node. The
    ///   node might not
    /// exist or might not be responding. Undeliverable invocations don't count
    /// against the parent
    /// command's `MaxErrors` limit and don't contribute to whether the parent
    /// command
    /// status is Success or Incomplete. This is a terminal state.
    ///
    /// * Terminated: The parent command exceeded its `MaxErrors` limit and
    ///   subsequent
    /// command invocations were canceled by the system. This is a terminal state.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .command_id = "CommandId",
        .comment = "Comment",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .execution_elapsed_time = "ExecutionElapsedTime",
        .execution_end_date_time = "ExecutionEndDateTime",
        .execution_start_date_time = "ExecutionStartDateTime",
        .instance_id = "InstanceId",
        .plugin_name = "PluginName",
        .response_code = "ResponseCode",
        .standard_error_content = "StandardErrorContent",
        .standard_error_url = "StandardErrorUrl",
        .standard_output_content = "StandardOutputContent",
        .standard_output_url = "StandardOutputUrl",
        .status = "Status",
        .status_details = "StatusDetails",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommandInvocationInput, options: Options) !GetCommandInvocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommandInvocationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetCommandInvocation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommandInvocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCommandInvocationOutput, body, allocator);
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
