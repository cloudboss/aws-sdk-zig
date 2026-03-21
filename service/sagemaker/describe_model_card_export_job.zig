const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModelCardExportArtifacts = @import("model_card_export_artifacts.zig").ModelCardExportArtifacts;
const ModelCardExportOutputConfig = @import("model_card_export_output_config.zig").ModelCardExportOutputConfig;
const ModelCardExportJobStatus = @import("model_card_export_job_status.zig").ModelCardExportJobStatus;

pub const DescribeModelCardExportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the model card export job to describe.
    model_card_export_job_arn: []const u8,

    pub const json_field_names = .{
        .model_card_export_job_arn = "ModelCardExportJobArn",
    };
};

pub const DescribeModelCardExportJobOutput = struct {
    /// The date and time that the model export job was created.
    created_at: i64,

    /// The exported model card artifacts.
    export_artifacts: ?ModelCardExportArtifacts = null,

    /// The failure reason if the model export job fails.
    failure_reason: ?[]const u8 = null,

    /// The date and time that the model export job was last modified.
    last_modified_at: i64,

    /// The Amazon Resource Name (ARN) of the model card export job.
    model_card_export_job_arn: []const u8,

    /// The name of the model card export job to describe.
    model_card_export_job_name: []const u8,

    /// The name or Amazon Resource Name (ARN) of the model card that the model
    /// export job exports.
    model_card_name: []const u8,

    /// The version of the model card that the model export job exports.
    model_card_version: i32,

    /// The export output details for the model card.
    output_config: ?ModelCardExportOutputConfig = null,

    /// The completion status of the model card export job.
    ///
    /// * `InProgress`: The model card export job is in progress.
    /// * `Completed`: The model card export job is complete.
    /// * `Failed`: The model card export job failed. To see the reason for the
    ///   failure, see the `FailureReason` field in the response to a
    ///   `DescribeModelCardExportJob` call.
    status: ModelCardExportJobStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .export_artifacts = "ExportArtifacts",
        .failure_reason = "FailureReason",
        .last_modified_at = "LastModifiedAt",
        .model_card_export_job_arn = "ModelCardExportJobArn",
        .model_card_export_job_name = "ModelCardExportJobName",
        .model_card_name = "ModelCardName",
        .model_card_version = "ModelCardVersion",
        .output_config = "OutputConfig",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelCardExportJobInput, options: CallOptions) !DescribeModelCardExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelCardExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModelCardExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelCardExportJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelCardExportJobOutput, body, allocator);
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
