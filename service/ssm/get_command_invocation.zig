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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetCommandInvocationOutput) void {
        self._arena.deinit();
    }

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

pub fn execute(client: *Client, input: GetCommandInvocationInput, options: Options) !GetCommandInvocationOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetCommandInvocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ssm", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSSM.GetCommandInvocation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetCommandInvocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCommandInvocationOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        return .{ .associated_instances = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        return .{ .association_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        return .{ .association_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        return .{ .association_execution_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        return .{ .association_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        return .{ .association_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        return .{ .automation_definition_not_approved_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        return .{ .automation_definition_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        return .{ .automation_definition_version_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        return .{ .automation_execution_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        return .{ .automation_execution_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        return .{ .automation_step_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        return .{ .compliance_type_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        return .{ .custom_schema_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        return .{ .document_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        return .{ .document_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        return .{ .document_permission_limit = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        return .{ .document_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        return .{ .does_not_exist_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        return .{ .duplicate_document_content = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        return .{ .duplicate_document_version_name = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        return .{ .duplicate_instance_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        return .{ .feature_not_available_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        return .{ .hierarchy_level_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        return .{ .hierarchy_type_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        return .{ .idempotent_parameter_mismatch = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        return .{ .incompatible_policy_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .internal_server_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        return .{ .invalid_activation = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        return .{ .invalid_activation_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        return .{ .invalid_aggregator_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        return .{ .invalid_allowed_pattern_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        return .{ .invalid_association = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        return .{ .invalid_association_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        return .{ .invalid_automation_execution_parameters_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        return .{ .invalid_automation_signal_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        return .{ .invalid_automation_status_update_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        return .{ .invalid_command_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        return .{ .invalid_delete_inventory_parameters_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        return .{ .invalid_deletion_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        return .{ .invalid_document = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        return .{ .invalid_document_content = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        return .{ .invalid_document_operation = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        return .{ .invalid_document_schema_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        return .{ .invalid_document_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        return .{ .invalid_document_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        return .{ .invalid_filter = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        return .{ .invalid_filter_key = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        return .{ .invalid_filter_option = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        return .{ .invalid_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        return .{ .invalid_instance_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        return .{ .invalid_instance_information_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        return .{ .invalid_instance_property_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        return .{ .invalid_inventory_group_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        return .{ .invalid_inventory_item_context_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        return .{ .invalid_inventory_request_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        return .{ .invalid_item_content_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        return .{ .invalid_key_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .invalid_next_token = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        return .{ .invalid_notification_config = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        return .{ .invalid_option_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        return .{ .invalid_output_folder = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        return .{ .invalid_output_location = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        return .{ .invalid_parameters = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        return .{ .invalid_permission_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        return .{ .invalid_plugin_name = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        return .{ .invalid_policy_attribute_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        return .{ .invalid_policy_type_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        return .{ .invalid_resource_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        return .{ .invalid_resource_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        return .{ .invalid_result_attribute_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        return .{ .invalid_role = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        return .{ .invalid_schedule = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        return .{ .invalid_tag = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        return .{ .invalid_target = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        return .{ .invalid_target_maps = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        return .{ .invalid_type_name_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        return .{ .invalid_update = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        return .{ .invocation_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        return .{ .item_content_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        return .{ .item_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        return .{ .malformed_resource_policy_document_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        return .{ .max_document_size_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        return .{ .no_longer_supported_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        return .{ .ops_item_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        return .{ .ops_item_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        return .{ .ops_item_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        return .{ .ops_item_invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        return .{ .ops_item_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        return .{ .ops_item_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        return .{ .ops_item_related_item_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        return .{ .ops_item_related_item_association_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        return .{ .ops_metadata_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        return .{ .ops_metadata_invalid_argument_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        return .{ .ops_metadata_key_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        return .{ .ops_metadata_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        return .{ .ops_metadata_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        return .{ .ops_metadata_too_many_updates_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        return .{ .parameter_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        return .{ .parameter_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        return .{ .parameter_max_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        return .{ .parameter_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        return .{ .parameter_pattern_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        return .{ .parameter_version_label_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        return .{ .parameter_version_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        return .{ .policies_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        return .{ .resource_data_sync_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        return .{ .resource_data_sync_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        return .{ .resource_data_sync_count_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        return .{ .resource_data_sync_invalid_configuration_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        return .{ .resource_data_sync_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .resource_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        return .{ .resource_policy_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        return .{ .resource_policy_invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        return .{ .resource_policy_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        return .{ .resource_policy_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .service_quota_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        return .{ .service_setting_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        return .{ .status_unchanged = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        return .{ .sub_type_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        return .{ .target_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        return .{ .target_not_connected = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .throttling_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        return .{ .too_many_tags_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        return .{ .too_many_updates = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        return .{ .total_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        return .{ .unsupported_calendar_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        return .{ .unsupported_feature_required_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        return .{ .unsupported_inventory_item_context_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        return .{ .unsupported_inventory_schema_version_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        return .{ .unsupported_operating_system = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .unsupported_operation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        return .{ .unsupported_parameter_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        return .{ .unsupported_platform_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .validation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
