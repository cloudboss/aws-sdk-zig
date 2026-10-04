const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecursiveLoop = @import("recursive_loop.zig").RecursiveLoop;

pub const PutFunctionRecursionConfigInput = struct {
    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// If you set your function's recursive loop detection configuration to
    /// `Allow`, Lambda doesn't take any action when it detects your function being
    /// invoked as part of a recursive loop. We recommend that you only use this
    /// setting if your design intentionally uses a Lambda function to write data
    /// back to the same Amazon Web Services resource that invokes it.
    ///
    /// If you set your function's recursive loop detection configuration to
    /// `Terminate`, Lambda stops your function being invoked and notifies you when
    /// it detects your function being invoked as part of a recursive loop.
    ///
    /// By default, Lambda sets your function's configuration to `Terminate`.
    ///
    /// If your design intentionally uses a Lambda function to write data back to
    /// the same Amazon Web Services resource that invokes the function, then use
    /// caution and implement suitable guard rails to prevent unexpected charges
    /// being billed to your Amazon Web Services account. To learn more about best
    /// practices for using recursive invocation patterns, see [Recursive patterns
    /// that cause run-away Lambda
    /// functions](https://serverlessland.com/content/service/lambda/guides/aws-lambda-operator-guide/recursive-runaway) in Serverless Land.
    recursive_loop: RecursiveLoop,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .recursive_loop = "RecursiveLoop",
    };
};

pub const PutFunctionRecursionConfigOutput = struct {
    /// The status of your function's recursive loop detection configuration.
    ///
    /// When this value is set to `Allow`and Lambda detects your function being
    /// invoked as part of a recursive loop, it doesn't take any action.
    ///
    /// When this value is set to `Terminate` and Lambda detects your function being
    /// invoked as part of a recursive loop, it stops your function being invoked
    /// and notifies you.
    recursive_loop: ?RecursiveLoop = null,

    pub const json_field_names = .{
        .recursive_loop = "RecursiveLoop",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutFunctionRecursionConfigInput, options: CallOptions) !PutFunctionRecursionConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutFunctionRecursionConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2024-08-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/recursion-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecursiveLoop\":");
    try aws.json.writeValue(@TypeOf(input.recursive_loop), input.recursive_loop, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutFunctionRecursionConfigOutput {
    var result: PutFunctionRecursionConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutFunctionRecursionConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
