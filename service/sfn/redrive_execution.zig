const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RedriveExecutionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you don’t specify a client token, the Amazon
    /// Web Services SDK automatically generates a client token and uses it for the
    /// request to ensure idempotency. The API will return idempotent responses for
    /// the last 10 client tokens used to successfully redrive the execution. These
    /// client tokens are valid for up to 15 minutes after they are first used.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the execution to be redriven.
    execution_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .execution_arn = "executionArn",
    };
};

pub const RedriveExecutionOutput = struct {
    /// The date the execution was last redriven.
    redrive_date: i64,

    pub const json_field_names = .{
        .redrive_date = "redriveDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RedriveExecutionInput, options: CallOptions) !RedriveExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RedriveExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.RedriveExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RedriveExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RedriveExecutionOutput, body, allocator);
}
