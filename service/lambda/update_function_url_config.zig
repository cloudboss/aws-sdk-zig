const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionUrlAuthType = @import("function_url_auth_type.zig").FunctionUrlAuthType;
const Cors = @import("cors.zig").Cors;
const InvokeMode = @import("invoke_mode.zig").InvokeMode;

pub const UpdateFunctionUrlConfigInput = struct {
    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Control access to Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    auth_type: ?FunctionUrlAuthType = null,

    /// The [cross-origin resource sharing
    /// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
    /// your function URL.
    cors: ?Cors = null,

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

    /// Use one of the following options:
    ///
    /// * `BUFFERED` – This is the default option. Lambda invokes your function
    ///   using the `Invoke` API operation. Invocation results are available when
    ///   the payload is complete. The maximum payload size is 6 MB.
    /// * `RESPONSE_STREAM` – Your function streams payload results as they become
    ///   available. Lambda invokes your function using the
    ///   `InvokeWithResponseStream` API operation. The maximum response payload
    ///   size is 200 MB.
    invoke_mode: ?InvokeMode = null,

    /// The alias name.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .cors = "Cors",
        .function_name = "FunctionName",
        .invoke_mode = "InvokeMode",
        .qualifier = "Qualifier",
    };
};

pub const UpdateFunctionUrlConfigOutput = struct {
    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Control access to Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    auth_type: FunctionUrlAuthType,

    /// The [cross-origin resource sharing
    /// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
    /// your function URL.
    cors: ?Cors = null,

    /// When the function URL was created, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    creation_time: []const u8,

    /// The Amazon Resource Name (ARN) of your function.
    function_arn: []const u8,

    /// The HTTP URL endpoint for your function.
    function_url: []const u8,

    /// Use one of the following options:
    ///
    /// * `BUFFERED` – This is the default option. Lambda invokes your function
    ///   using the `Invoke` API operation. Invocation results are available when
    ///   the payload is complete. The maximum payload size is 6 MB.
    /// * `RESPONSE_STREAM` – Your function streams payload results as they become
    ///   available. Lambda invokes your function using the
    ///   `InvokeWithResponseStream` API operation. The maximum response payload
    ///   size is 200 MB.
    invoke_mode: ?InvokeMode = null,

    /// When the function URL configuration was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: []const u8,

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .cors = "Cors",
        .creation_time = "CreationTime",
        .function_arn = "FunctionArn",
        .function_url = "FunctionUrl",
        .invoke_mode = "InvokeMode",
        .last_modified_time = "LastModifiedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFunctionUrlConfigInput, options: CallOptions) !UpdateFunctionUrlConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFunctionUrlConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-10-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/url");
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Cors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.invoke_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InvokeMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFunctionUrlConfigOutput {
    var result: UpdateFunctionUrlConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFunctionUrlConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
