const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UserContext = @import("user_context.zig").UserContext;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;

pub const DescribePipelineInput = struct {
    /// The name or Amazon Resource Name (ARN) of the pipeline to describe.
    pipeline_name: []const u8,

    /// The ID of the pipeline version to describe.
    pipeline_version_id: ?i64 = null,

    pub const json_field_names = .{
        .pipeline_name = "PipelineName",
        .pipeline_version_id = "PipelineVersionId",
    };
};

pub const DescribePipelineOutput = struct {
    created_by: ?UserContext = null,

    /// The time when the pipeline was created.
    creation_time: ?i64 = null,

    last_modified_by: ?UserContext = null,

    /// The time when the pipeline was last modified.
    last_modified_time: ?i64 = null,

    /// The time when the pipeline was last run.
    last_run_time: ?i64 = null,

    /// Lists the parallelism configuration applied to the pipeline.
    parallelism_configuration: ?ParallelismConfiguration = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The JSON pipeline definition.
    pipeline_definition: ?[]const u8 = null,

    /// The description of the pipeline.
    pipeline_description: ?[]const u8 = null,

    /// The display name of the pipeline.
    pipeline_display_name: ?[]const u8 = null,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8 = null,

    /// The status of the pipeline execution.
    pipeline_status: ?PipelineStatus = null,

    /// The description of the pipeline version.
    pipeline_version_description: ?[]const u8 = null,

    /// The display name of the pipeline version.
    pipeline_version_display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that the pipeline uses to execute.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .last_run_time = "LastRunTime",
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_arn = "PipelineArn",
        .pipeline_definition = "PipelineDefinition",
        .pipeline_description = "PipelineDescription",
        .pipeline_display_name = "PipelineDisplayName",
        .pipeline_name = "PipelineName",
        .pipeline_status = "PipelineStatus",
        .pipeline_version_description = "PipelineVersionDescription",
        .pipeline_version_display_name = "PipelineVersionDisplayName",
        .role_arn = "RoleArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePipelineInput, options: Options) !DescribePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribePipeline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePipelineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePipelineOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
