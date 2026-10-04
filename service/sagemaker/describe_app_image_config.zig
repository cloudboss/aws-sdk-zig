const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppImageConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
