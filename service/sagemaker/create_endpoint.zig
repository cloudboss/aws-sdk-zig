const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentConfig = @import("deployment_config.zig").DeploymentConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateEndpointInput = struct {
    deployment_config: ?DeploymentConfig = null,

    /// The name of an endpoint configuration. For more information, see
    /// [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html).
    endpoint_config_name: []const u8,

    /// The name of the endpoint.The name must be unique within an Amazon Web
    /// Services Region in your Amazon Web Services account. The name is
    /// case-insensitive in `CreateEndpoint`, but the case is preserved and must be
    /// matched in
    /// [InvokeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_runtime_InvokeEndpoint.html).
    endpoint_name: []const u8,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .endpoint_config_name = "EndpointConfigName",
        .endpoint_name = "EndpointName",
        .tags = "Tags",
    };
};

pub const CreateEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointInput, options: CallOptions) !CreateEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEndpointOutput, body, allocator);
}
