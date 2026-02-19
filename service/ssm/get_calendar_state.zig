const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CalendarState = @import("calendar_state.zig").CalendarState;

pub const GetCalendarStateInput = struct {
    /// (Optional) The specific time for which you want to get calendar state
    /// information, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// If you don't specify a
    /// value or `AtTime`, the current time is used.
    at_time: ?[]const u8 = null,

    /// The names of Amazon Resource Names (ARNs) of the Systems Manager documents
    /// (SSM documents) that
    /// represent the calendar entries for which you want to get the state.
    calendar_names: []const []const u8,

    pub const json_field_names = .{
        .at_time = "AtTime",
        .calendar_names = "CalendarNames",
    };
};

pub const GetCalendarStateOutput = struct {
    /// The time, as an [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) string,
    /// that you specified in your command. If you don't specify a time,
    /// `GetCalendarState`
    /// uses the current time.
    at_time: ?[]const u8 = null,

    /// The time, as an [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) string,
    /// that the calendar state will change. If the current calendar state is
    /// `OPEN`,
    /// `NextTransitionTime` indicates when the calendar state changes to
    /// `CLOSED`, and vice-versa.
    next_transition_time: ?[]const u8 = null,

    /// The state of the calendar. An `OPEN` calendar indicates that actions are
    /// allowed
    /// to proceed, and a `CLOSED` calendar indicates that actions aren't allowed to
    /// proceed.
    state: ?CalendarState = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetCalendarStateOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .at_time = "AtTime",
        .next_transition_time = "NextTransitionTime",
        .state = "State",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetCalendarStateInput, options: Options) !GetCalendarStateOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetCalendarStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSSM.GetCalendarState");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetCalendarStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCalendarStateOutput, body, alloc);
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
