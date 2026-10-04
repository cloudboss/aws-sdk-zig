const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsServiceRequestConfiguration = @import("aws_service_request_configuration.zig").AwsServiceRequestConfiguration;
const ConcurrentExecutorConfiguration = @import("concurrent_executor_configuration.zig").ConcurrentExecutorConfiguration;
const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const FunctionType = @import("function_type.zig").FunctionType;
const HttpRequestConfiguration = @import("http_request_configuration.zig").HttpRequestConfiguration;
const SequentialExecutorConfiguration = @import("sequential_executor_configuration.zig").SequentialExecutorConfiguration;
const VastRequestConfiguration = @import("vast_request_configuration.zig").VastRequestConfiguration;

pub const GetFunctionInput = struct {
    /// The identifier of the function.
    function_id: []const u8,

    pub const json_field_names = .{
        .function_id = "FunctionId",
    };
};

pub const GetFunctionOutput = struct {
    /// The Amazon Resource Name (ARN) of the function.
    arn: ?[]const u8 = null,

    /// The configuration for an `AWS_SERVICE_REQUEST` function. Specifies the
    /// target service, target Region, and request parameters.
    aws_service_request_configuration: ?AwsServiceRequestConfiguration = null,

    /// The configuration for a `CONCURRENT_EXECUTOR` function.
    concurrent_executor_configuration: ?ConcurrentExecutorConfiguration = null,

    /// The configuration for a `CUSTOM_OUTPUT` function.
    custom_output_configuration: ?CustomOutputConfiguration = null,

    /// A description of the function.
    description: ?[]const u8 = null,

    /// The identifier of the function.
    function_id: []const u8,

    /// The type of the function.
    function_type: FunctionType,

    /// The configuration for an `HTTP_REQUEST` function.
    http_request_configuration: ?HttpRequestConfiguration = null,

    /// The configuration for a `SEQUENTIAL_EXECUTOR` function.
    sequential_executor_configuration: ?SequentialExecutorConfiguration = null,

    /// The tags assigned to the function. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for a `VAST_REQUEST` function.
    vast_request_configuration: ?VastRequestConfiguration = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_service_request_configuration = "AwsServiceRequestConfiguration",
        .concurrent_executor_configuration = "ConcurrentExecutorConfiguration",
        .custom_output_configuration = "CustomOutputConfiguration",
        .description = "Description",
        .function_id = "FunctionId",
        .function_type = "FunctionType",
        .http_request_configuration = "HttpRequestConfiguration",
        .sequential_executor_configuration = "SequentialExecutorConfiguration",
        .tags = "Tags",
        .vast_request_configuration = "VastRequestConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFunctionInput, options: CallOptions) !GetFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/function/");
    try path_buf.appendSlice(allocator, input.function_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFunctionOutput {
    const result: GetFunctionOutput = try aws.json.parseJsonObject(
        GetFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
