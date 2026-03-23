const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CodeEditorAppImageConfig = @import("code_editor_app_image_config.zig").CodeEditorAppImageConfig;
const JupyterLabAppImageConfig = @import("jupyter_lab_app_image_config.zig").JupyterLabAppImageConfig;
const KernelGatewayImageConfig = @import("kernel_gateway_image_config.zig").KernelGatewayImageConfig;

pub const DescribeAppImageConfigInput = struct {
    /// The name of the AppImageConfig to describe.
    app_image_config_name: []const u8,

    pub const json_field_names = .{
        .app_image_config_name = "AppImageConfigName",
    };
};

pub const DescribeAppImageConfigOutput = struct {
    /// The ARN of the AppImageConfig.
    app_image_config_arn: ?[]const u8 = null,

    /// The name of the AppImageConfig.
    app_image_config_name: ?[]const u8 = null,

    /// The configuration of the Code Editor app.
    code_editor_app_image_config: ?CodeEditorAppImageConfig = null,

    /// When the AppImageConfig was created.
    creation_time: ?i64 = null,

    /// The configuration of the JupyterLab app.
    jupyter_lab_app_image_config: ?JupyterLabAppImageConfig = null,

    /// The configuration of a KernelGateway app.
    kernel_gateway_image_config: ?KernelGatewayImageConfig = null,

    /// When the AppImageConfig was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .app_image_config_arn = "AppImageConfigArn",
        .app_image_config_name = "AppImageConfigName",
        .code_editor_app_image_config = "CodeEditorAppImageConfig",
        .creation_time = "CreationTime",
        .jupyter_lab_app_image_config = "JupyterLabAppImageConfig",
        .kernel_gateway_image_config = "KernelGatewayImageConfig",
        .last_modified_time = "LastModifiedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppImageConfigInput, options: CallOptions) !DescribeAppImageConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppImageConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAppImageConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppImageConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAppImageConfigOutput, body, allocator);
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
