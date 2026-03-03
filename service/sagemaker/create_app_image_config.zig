const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CodeEditorAppImageConfig = @import("code_editor_app_image_config.zig").CodeEditorAppImageConfig;
const JupyterLabAppImageConfig = @import("jupyter_lab_app_image_config.zig").JupyterLabAppImageConfig;
const KernelGatewayImageConfig = @import("kernel_gateway_image_config.zig").KernelGatewayImageConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateAppImageConfigInput = struct {
    /// The name of the AppImageConfig. Must be unique to your account.
    app_image_config_name: []const u8,

    /// The `CodeEditorAppImageConfig`. You can only specify one image kernel in the
    /// AppImageConfig API. This kernel is shown to users before the image starts.
    /// After the image runs, all kernels are visible in Code Editor.
    code_editor_app_image_config: ?CodeEditorAppImageConfig = null,

    /// The `JupyterLabAppImageConfig`. You can only specify one image kernel in the
    /// `AppImageConfig` API. This kernel is shown to users before the image starts.
    /// After the image runs, all kernels are visible in JupyterLab.
    jupyter_lab_app_image_config: ?JupyterLabAppImageConfig = null,

    /// The KernelGatewayImageConfig. You can only specify one image kernel in the
    /// AppImageConfig API. This kernel will be shown to users before the image
    /// starts. Once the image runs, all kernels are visible in JupyterLab.
    kernel_gateway_image_config: ?KernelGatewayImageConfig = null,

    /// A list of tags to apply to the AppImageConfig.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .app_image_config_name = "AppImageConfigName",
        .code_editor_app_image_config = "CodeEditorAppImageConfig",
        .jupyter_lab_app_image_config = "JupyterLabAppImageConfig",
        .kernel_gateway_image_config = "KernelGatewayImageConfig",
        .tags = "Tags",
    };
};

pub const CreateAppImageConfigOutput = struct {
    /// The ARN of the AppImageConfig.
    app_image_config_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_image_config_arn = "AppImageConfigArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppImageConfigInput, options: CallOptions) !CreateAppImageConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAppImageConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAppImageConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAppImageConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAppImageConfigOutput, body, allocator);
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
