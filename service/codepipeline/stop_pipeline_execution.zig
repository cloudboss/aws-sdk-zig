const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const StopPipelineExecutionInput = struct {
    /// Use this option to stop the pipeline execution by abandoning, rather than
    /// finishing,
    /// in-progress actions.
    ///
    /// This option can lead to failed or out-of-sequence tasks.
    abandon: ?bool = null,

    /// The ID of the pipeline execution to be stopped in the current stage. Use the
    /// `GetPipelineState` action to retrieve the current
    /// pipelineExecutionId.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline to stop.
    pipeline_name: []const u8,

    /// Use this option to enter comments, such as the reason the pipeline was
    /// stopped.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .abandon = "abandon",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .reason = "reason",
    };
};

pub const StopPipelineExecutionOutput = struct {
    /// The unique system-generated ID of the pipeline execution that was stopped.
    pipeline_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopPipelineExecutionInput, options: Options) !StopPipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopPipelineExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.StopPipelineExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopPipelineExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopPipelineExecutionOutput, body, allocator);
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
