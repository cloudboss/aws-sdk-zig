const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateRuntimeOn = @import("update_runtime_on.zig").UpdateRuntimeOn;

pub const PutRuntimeManagementConfigInput = struct {
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

    /// The ARN of the runtime version you want the function to use.
    ///
    /// This is only required if you're using the **Manual** runtime update mode.
    runtime_version_arn: ?[]const u8 = null,

    /// Specify the runtime update mode.
    ///
    /// * **Auto (default)** - Automatically update to the most recent and secure
    ///   runtime version using a [Two-phase runtime version
    ///   rollout](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html#runtime-management-two-phase). This is the best choice for most customers to ensure they always benefit from runtime updates.
    /// * **Function update** - Lambda updates the runtime of your function to the
    ///   most recent and secure runtime version when you update your function. This
    ///   approach synchronizes runtime updates with function deployments, giving
    ///   you control over when runtime updates are applied and allowing you to
    ///   detect and mitigate rare runtime update incompatibilities early. When
    ///   using this setting, you need to regularly update your functions to keep
    ///   their runtime up-to-date.
    /// * **Manual** - You specify a runtime version in your function configuration.
    ///   The function will use this runtime version indefinitely. In the rare case
    ///   where a new runtime version is incompatible with an existing function,
    ///   this allows you to roll back your function to an earlier runtime version.
    ///   For more information, see [Roll back a runtime
    ///   version](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html#runtime-management-rollback).
    update_runtime_on: UpdateRuntimeOn,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .qualifier = "Qualifier",
        .runtime_version_arn = "RuntimeVersionArn",
        .update_runtime_on = "UpdateRuntimeOn",
    };
};

pub const PutRuntimeManagementConfigOutput = struct {
    /// The ARN of the function
    function_arn: []const u8,

    /// The ARN of the runtime the function is configured to use. If the runtime
    /// update mode is **manual**, the ARN is returned, otherwise `null` is
    /// returned.
    runtime_version_arn: ?[]const u8 = null,

    /// The runtime update mode.
    update_runtime_on: UpdateRuntimeOn,

    pub const json_field_names = .{
        .function_arn = "FunctionArn",
        .runtime_version_arn = "RuntimeVersionArn",
        .update_runtime_on = "UpdateRuntimeOn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRuntimeManagementConfigInput, options: CallOptions) !PutRuntimeManagementConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRuntimeManagementConfigInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.runtime_version_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RuntimeVersionArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateRuntimeOn\":");
    try aws.json.writeValue(@TypeOf(input.update_runtime_on), input.update_runtime_on, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRuntimeManagementConfigOutput {
    const result: PutRuntimeManagementConfigOutput = try aws.json.parseJsonObject(
        PutRuntimeManagementConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
