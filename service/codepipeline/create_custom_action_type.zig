const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActionCategory = @import("action_category.zig").ActionCategory;
const ActionConfigurationProperty = @import("action_configuration_property.zig").ActionConfigurationProperty;
const ArtifactDetails = @import("artifact_details.zig").ArtifactDetails;
const ActionTypeSettings = @import("action_type_settings.zig").ActionTypeSettings;
const Tag = @import("tag.zig").Tag;
const ActionType = @import("action_type.zig").ActionType;

pub const CreateCustomActionTypeInput = struct {
    /// The category of the custom action, such as a build action or a test
    /// action.
    category: ActionCategory,

    /// The configuration properties for the custom action.
    ///
    /// You can refer to a name in the configuration properties of the custom action
    /// within the URL templates by following the format of {Config:name}, as long
    /// as the
    /// configuration property is both required and not secret. For more
    /// information, see
    /// [Create a
    /// Custom Action for a
    /// Pipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/how-to-create-custom-action.html).
    configuration_properties: ?[]const ActionConfigurationProperty = null,

    /// The details of the input artifact for the action, such as its commit ID.
    input_artifact_details: ArtifactDetails,

    /// The details of the output artifact of the action, such as its commit ID.
    output_artifact_details: ArtifactDetails,

    /// The provider of the service used in the custom action, such as
    /// CodeDeploy.
    provider: []const u8,

    /// URLs that provide users information about this custom action.
    settings: ?ActionTypeSettings = null,

    /// The tags for the custom action.
    tags: ?[]const Tag = null,

    /// The version identifier of the custom action.
    version: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .configuration_properties = "configurationProperties",
        .input_artifact_details = "inputArtifactDetails",
        .output_artifact_details = "outputArtifactDetails",
        .provider = "provider",
        .settings = "settings",
        .tags = "tags",
        .version = "version",
    };
};

pub const CreateCustomActionTypeOutput = struct {
    /// Returns information about the details of an action type.
    action_type: ?ActionType = null,

    /// Specifies the tags applied to the custom action.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .action_type = "actionType",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomActionTypeInput, options: CallOptions) !CreateCustomActionTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codepipeline");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomActionTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.CreateCustomActionType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomActionTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCustomActionTypeOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ActionExecutionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .action_execution_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .action_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActionTypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .action_type_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalAlreadyCompletedException")) {
        return .{ .arena = arena, .kind = .{ .approval_already_completed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentPipelineExecutionsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_pipeline_executions_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionNotOverridableException")) {
        return .{ .arena = arena, .kind = .{ .condition_not_overridable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatedStopRequestException")) {
        return .{ .arena = arena, .kind = .{ .duplicated_stop_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActionDeclarationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_action_declaration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBlockerDeclarationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_blocker_declaration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidJobException")) {
        return .{ .arena = arena, .kind = .{ .invalid_job_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidJobStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_job_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNonceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_nonce_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStageDeclarationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_stage_declaration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStructureException")) {
        return .{ .arena = arena, .kind = .{ .invalid_structure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWebhookAuthenticationParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_webhook_authentication_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWebhookFilterPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_webhook_filter_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .job_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotLatestPipelineExecutionException")) {
        return .{ .arena = arena, .kind = .{ .not_latest_pipeline_execution_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutputVariablesSizeExceededException")) {
        return .{ .arena = arena, .kind = .{ .output_variables_size_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineExecutionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_execution_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineExecutionNotStoppableException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_execution_not_stoppable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineExecutionOutdatedException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_execution_outdated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineNameInUseException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_name_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineVersionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_version_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .request_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "StageNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stage_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StageNotRetryableException")) {
        return .{ .arena = arena, .kind = .{ .stage_not_retryable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToRollbackStageException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_rollback_stage_exception = .{
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
    if (std.mem.eql(u8, error_code, "WebhookNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .webhook_not_found_exception = .{
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
