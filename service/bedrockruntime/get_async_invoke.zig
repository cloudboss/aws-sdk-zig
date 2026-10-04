const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AsyncInvokeOutputDataConfig = @import("async_invoke_output_data_config.zig").AsyncInvokeOutputDataConfig;
const AsyncInvokeStatus = @import("async_invoke_status.zig").AsyncInvokeStatus;

pub const GetAsyncInvokeInput = struct {
    /// The invocation's ARN.
    invocation_arn: []const u8,

    pub const json_field_names = .{
        .invocation_arn = "invocationArn",
    };
};

pub const GetAsyncInvokeOutput = struct {
    /// The invocation's idempotency token.
    client_request_token: ?[]const u8 = null,

    /// When the invocation ended.
    end_time: ?i64 = null,

    /// An error message.
    failure_message: ?[]const u8 = null,

    /// The invocation's ARN.
    invocation_arn: []const u8,

    /// The invocation's last modified time.
    last_modified_time: ?i64 = null,

    /// The invocation's model ARN.
    model_arn: []const u8,

    /// Output data settings.
    output_data_config: ?AsyncInvokeOutputDataConfig = null,

    /// The invocation's status.
    status: AsyncInvokeStatus,

    /// When the invocation request was submitted.
    submit_time: i64,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .end_time = "endTime",
        .failure_message = "failureMessage",
        .invocation_arn = "invocationArn",
        .last_modified_time = "lastModifiedTime",
        .model_arn = "modelArn",
        .output_data_config = "outputDataConfig",
        .status = "status",
        .submit_time = "submitTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAsyncInvokeInput, options: CallOptions) !GetAsyncInvokeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockfrontendservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAsyncInvokeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-runtime", "Bedrock Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/async-invoke/");
    try path_buf.appendSlice(allocator, input.invocation_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAsyncInvokeOutput {
    var result: GetAsyncInvokeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAsyncInvokeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
