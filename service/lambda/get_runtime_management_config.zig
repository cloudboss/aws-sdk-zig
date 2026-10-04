const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateRuntimeOn = @import("update_runtime_on.zig").UpdateRuntimeOn;

pub const GetRuntimeManagementConfigInput = struct {
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

    /// Specify a version of the function. This can be `$LATEST` or a published
    /// version number. If no value is specified, the configuration for the
    /// `$LATEST` version is returned.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .qualifier = "Qualifier",
    };
};

pub const GetRuntimeManagementConfigOutput = struct {
    /// The Amazon Resource Name (ARN) of your function.
    function_arn: ?[]const u8 = null,

    /// The ARN of the runtime the function is configured to use. If the runtime
    /// update mode is **Manual**, the ARN is returned, otherwise `null` is
    /// returned.
    runtime_version_arn: ?[]const u8 = null,

    /// The current runtime update mode of the function.
    update_runtime_on: ?UpdateRuntimeOn = null,

    pub const json_field_names = .{
        .function_arn = "FunctionArn",
        .runtime_version_arn = "RuntimeVersionArn",
        .update_runtime_on = "UpdateRuntimeOn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRuntimeManagementConfigInput, options: CallOptions) !GetRuntimeManagementConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRuntimeManagementConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-07-20/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/runtime-management-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRuntimeManagementConfigOutput {
    var result: GetRuntimeManagementConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRuntimeManagementConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
